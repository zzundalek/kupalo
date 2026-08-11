import 'package:logger/logger.dart';

class AppLogger {
  factory AppLogger() {
    return _instance ??= AppLogger._(
      Logger(
        printer: PrettyPrinter(
          colors: false,
        ),
      ),
    );
  }
  const AppLogger._(this._logger);
  final Logger _logger;
  static AppLogger? _instance;

  void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(Level.info, message, time: time, error: error, stackTrace: stackTrace);
  }
}
