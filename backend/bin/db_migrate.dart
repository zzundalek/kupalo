import 'dart:io';
import 'package:postgres/postgres.dart';

typedef RunTransation<R> = Future<R> Function(TxSession session);

typedef ConnSettings = ({
  String host,
  String dbName,
  String username,
  String password,
  bool useSsl,
  int? port,
});

ConnSettings getConnectionSettings() {
  final env = Platform.environment;
  final user = loadReqEnvStr('POSTGRES_USER');
  final password = loadReqEnvStr('POSTGRES_PASSWORD');
  final host = loadReqEnvStr('POSTGRES_HOST');
  final dbName = loadReqEnvStr('POSTGRES_DB');
  final useSsl = bool.parse(loadReqEnvStr('POSTGRES_SSL'));
  final port = env.containsKey('POSTGRES_PORT') ? int.parse(Platform.environment['POSTGRES_PORT']!) : null;

  return (
    host: host,
    dbName: dbName,
    username: user,
    password: password,
    useSsl: useSsl,
    port: port,
  );
}

class Db {
  Db._(this._connection);
  final Connection _connection;
  Future<void>? _closeFuture;
  static const maxNumberOfRetries = 4;
  static const baseWaitRetrySeconds = 1;

  static Future<Db> open(ConnSettings settings) async {
    stdout.writeln('Opening the connection...');
    var retriesCount = 0;
    late final Connection connection;
    while (true) {
      try {
        connection = await Connection.open(
          Endpoint(
            host: settings.host,
            database: settings.dbName,
            username: settings.username,
            password: settings.password,
            port: settings.port ?? 5432,
          ),
          settings: settings.useSsl ? null : const ConnectionSettings(sslMode: SslMode.disable),
        );
        break;
      } catch (_) {
        if (retriesCount < maxNumberOfRetries) {
          retriesCount++;
          await Future<dynamic>.delayed(Duration(seconds: baseWaitRetrySeconds * retriesCount));
          stdout.writeln('Connection failed, trying again... ($retriesCount/$maxNumberOfRetries)');
          continue;
        } else {
          rethrow;
        }
      }
    }
    stdout.writeln('Connection established!');
    return Db._(connection);
  }

  Future<void> _close({required bool force}) async {
    _closeFuture = _connection.close(force: force);
    stdout.writeln('Closing the connection...');
    await _closeFuture;
    stdout.writeln('Connection closed!');
  }

  Future<void> close({bool force = false}) async {
    return _closeFuture ??= _close(force: force);
  }

  Future<void> runTx<T>(RunTransation<T> fn) async {
    await _connection.runTx(fn);
  }
}

String loadReqEnvStr(String key) {
  final env = Platform.environment;
  if (!env.containsKey(key)) {
    throw StateError('Environment variable $key is required!');
  }

  return env[key]!;
}

/// Exectures the DB migration including data seeding
///
/// Accepts environment parameters:
/// - POSTGRES_HOST
/// - POSTGRES_DB
/// - POSTGRES_USER
/// - POSTGRES_PASSWORD
/// - POSTGRES_PORT (default value is 5432)
/// - POSTGRES_SSL (true/false)
///
/// Example execution:
///
/// POSTGRES_USER=postgres \
/// POSTGRES_PASSWORD=postgres \
/// POSTGRES_HOST=localhost \
/// POSTGRES_DB=kupalo \
/// POSTGRES_SSL=false \
/// dart bin/db_migrate.dart
///
Future<void> main() async {
  final db = await Db.open(getConnectionSettings());
  final signalSubscription = ProcessSignal.sigint.watch().listen((e) async {
    await db.close(force: true);
    exit(e.signalNumber);
  });

  try {
    stdout.writeln('Fetching the migration scripts...');
    final scriptDir = File(Platform.script.toFilePath()).parent;
    final migrationDir = '${scriptDir.path}/../db/migrations/20260801';

    final migrationSqls = await Future.wait([
      File('$migrationDir/001_extensions.sql').readAsString(),
      File('$migrationDir/002_tables.sql').readAsString(),
      File('$migrationDir/003_constraints.sql').readAsString(),
      File('$migrationDir/004_indexes.sql').readAsString(),
      File('$migrationDir/005_views.sql').readAsString(),
    ]);

    final seedSqls = await Future.wait([
      File('$migrationDir/seeds/01.sql').readAsString(),
    ]);

    // TODO(zzu): add proper groups and schema versioning
    final migrationSteps = [
      (
        migration: migrationSqls,
        seed: seedSqls,
      ),
    ];

    // TODO(zzu): add as a parameter
    const applySeeding = true;

    stdout
      ..writeln('Migration scripts fetched!')
      ..writeln('Starting the migration...');

    await db.runTx((s) async {
      for (final step in migrationSteps) {
        for (final sql in step.migration) {
          await s.execute(sql, queryMode: .simple);
        }
        if (applySeeding) {
          for (final sql in step.seed) {
            await s.execute(sql, queryMode: .simple);
          }
        }
      }
    });
    stdout.write('Migration completed!');
    // zzu: Retrying on any error here is intentional
    // ignore: avoid_catches_without_on_clauses
  } catch (e, stackTrace) {
    stderr
      ..write('Migration error: $e')
      ..write(stackTrace);
    exitCode = 1;
  } finally {
    await signalSubscription.cancel();
    await db.close();
  }
}
