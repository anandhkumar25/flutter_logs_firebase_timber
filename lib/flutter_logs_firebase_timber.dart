library flutter_logs_firebase_timber;

import 'package:flutter_logs_firebase_timber/models/device_info.dart';
import 'package:flutter_logs_firebase_timber/remote/logs_tree.dart';

class FlutterLogsFirebaseTimber {
  static LogsTree? _logTree;
  static DeviceInfo? _deviceInfo;
  FlutterLogsFirebaseTimber._(); // A private constructor to prevent instantiation.

  /// Initializes the logging system by creating a [DeviceInfo] instance
  /// and a [LogsTree] if they are not already created.
  ///
  /// This method should be called once during the application startup.
  static Future<void> initialize() async {
    if (_logTree == null) {
      _deviceInfo = await DeviceInfo.create();
      _logTree = LogsTree(_deviceInfo!);
    }
  }

  /// Logs a message with the given [logLevel], [tag], [message], and optional [error].
  ///
  /// This method uses the initialized [LogsTree] to log the message.
  static void log(
      {required LogLevel logLevel,
      required String tag,
      required String message,
      required dynamic error}) {
    _logTree?.log(logLevel, tag, message, error);
  }
}
