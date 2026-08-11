import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

enum PackingType {
  PACKED,
  WORN,
  CONSUMABLE,
}

class Users extends Table {
  TextColumn get id => text().check(id.length.equals(36))();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Tags extends Table {
  TextColumn get id => text().check(id.length.equals(36))();

  TextColumn get userId => text().references(Users, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class GearListCategories extends Table {
  TextColumn get gearListId => text().references(GearLists, #id)();
  TextColumn get categoryId => text().check(categoryId.length.equals(36))();

  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 5000)();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {gearListId, categoryId};
}

class Gear extends Table {
  TextColumn get id => text().check(id.length.equals(36))();

  TextColumn get userId => text().references(Users, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 5000)();
  IntColumn get weightGrams => integer()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class GearLists extends Table {
  TextColumn get id => text().check(id.length.equals(36))();

  TextColumn get userId => text().references(Users, #id)();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get description => text().nullable().withLength(min: 1, max: 5000)();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class GearListItems extends Table {
  TextColumn get id => text().check(id.length.equals(36))();

  TextColumn get gearId => text().references(Gear, #id)();
  TextColumn get gearListId => text().references(GearLists, #id)();
  TextColumn get categoryId => text().nullable().check(categoryId.length.equals(36))();
  IntColumn get quantity => integer()();
  TextColumn get packingType => textEnum<PackingType>()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<String> get customConstraints => [
    'FOREIGN KEY (gear_list_id, category_id) REFERENCES gear_list_categories (gear_list_id, category_id)',
  ];
}

class GearTags extends Table {
  TextColumn get gearId => text().references(Gear, #id)();
  TextColumn get tagId => text().references(Tags, #id)();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get archivedAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {gearId, tagId};
}

@DriftDatabase(tables: [Users, Tags, GearListCategories, Gear, GearLists, GearListItems, GearTags])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'kupalo_db',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      beforeOpen: (_) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
