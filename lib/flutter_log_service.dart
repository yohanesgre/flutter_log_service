library flutter_log_service;

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogService {
  static late Logger _logger;

  static void init({bool usePrettyPrinter = false}) {
    _logger = Logger(printer: usePrettyPrinter ? PrettyPrinter() : null);
  }

  static void debug(String message) {
    if (kDebugMode) {
      _logger.d(message);
    }
  }

  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      _logger.e(message, error, stackTrace);
    }
  }
}
