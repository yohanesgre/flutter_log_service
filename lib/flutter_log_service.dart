library flutter_log_service;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LogService {
  static late Logger _logger;

  static void init({bool usePrettyPrinter = false}) {
    _logger = Logger(printer: usePrettyPrinter ? PrettyPrinter() : null);
  }

  static void debug(dynamic message,
      [dynamic error, StackTrace? stackTrace, bool cloud = false]) {
    if (kDebugMode) {
      _logger.d(message, error, stackTrace);
    } else if (kReleaseMode && cloud) {
      cloudLog(message,
          level: 'debug', exception: error, stackTrace: stackTrace);
    }
  }

  static void info(dynamic message,
      [dynamic error, StackTrace? stackTrace, bool cloud = false]) {
    if (kDebugMode) {
      _logger.i(message, error, stackTrace);
    } else if (kReleaseMode && cloud) {
      cloudLog(message,
          level: 'info', exception: error, stackTrace: stackTrace);
    }
  }

  static void error(dynamic message,
      [dynamic error, StackTrace? stackTrace, bool cloud = false]) {
    if (kDebugMode) {
      _logger.e(message, error, stackTrace);
    } else if (kReleaseMode && cloud) {
      cloudLog(message,
          level: 'error', exception: error, stackTrace: stackTrace);
    }
  }

  static void warning(dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.w(message, error, stackTrace);
    } else {
      cloudLog(message,
          level: 'warning', exception: error, stackTrace: stackTrace);
    }
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.wtf(message, error, stackTrace);
    } else {
      cloudLog(message, level: 'wtf', exception: error, stackTrace: stackTrace);
    }
  }

  static void verbose(dynamic message,
      [dynamic error, StackTrace? stackTrace, bool cloud = false]) {
    if (kDebugMode) {
      _logger.v(message, error, stackTrace);
    } else if (kReleaseMode && cloud) {
      cloudLog(message,
          level: 'verbose', exception: error, stackTrace: stackTrace);
    }
  }

  static cloudLog(String msg,
      {dynamic level, dynamic exception, dynamic stackTrace}) async {
    if (null != exception || null != stackTrace) {
      return await Sentry.captureException(exception,
          stackTrace: stackTrace, hint: level);
    }

    return await Sentry.captureMessage(msg);
  }
}
