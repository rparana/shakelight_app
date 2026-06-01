import 'package:flutter/services.dart';

class AppErrorHandler {
  static String getMessage(Object error) {
    if (error is PlatformException) {
      return error.message ?? 'A platform error occurred: ${error.code}';
    }
    return error.toString();
  }
}
