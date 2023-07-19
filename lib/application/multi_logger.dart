import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@prod
@dev
@LazySingleton(as: Logger)
class MultiLogger implements Logger {
  const MultiLogger(
    @Named('logger') this._logger,
    this._analytics,
    this._crashlytics,
  );

  final Logger _logger;
  final FirebaseAnalytics _analytics;
  final FirebaseCrashlytics _crashlytics;

  @override
  void close() {}

  @override
  void d(message, [error, StackTrace? stackTrace]) {
    _logger.d(message, error, stackTrace);
  }

  @override
  void e(message, [error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
    _crashlytics.recordError(error, stackTrace, information: [
      if (message is Object) message,
    ]);
  }

  @override
  void i(message, [error, StackTrace? stackTrace]) {
    _logger.i(message, error, stackTrace);
    _analytics.logEvent(name: '$message');
  }

  @override
  bool isClosed() => false;

  @override
  void log(Level level, message, [error, StackTrace? stackTrace]) {
    _logger.log(level, message, error, stackTrace);
  }

  @override
  void v(message, [error, StackTrace? stackTrace]) {
    _logger.v(message, error, stackTrace);
  }

  @override
  void w(message, [error, StackTrace? stackTrace]) {
    _logger.w(message, error, stackTrace);
  }

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {
    _logger.wtf(message, error, stackTrace);
    _crashlytics.recordError(error, stackTrace, information: [
      if (message is Object) message,
    ]);
  }
}
