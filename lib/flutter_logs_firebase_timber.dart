library flutter_logs_firebase_timber;

import 'package:flutter_logs_firebase_timber/models/device_info.dart';
import 'package:flutter_logs_firebase_timber/remote/logs_tree.dart';

class FlutterLogsFirebaseTimber {
  static LogsTree? _logTree;
  static DeviceInfo? _deviceInfo;
  FlutterLogsFirebaseTimber._(); //Make the constructor private

  static Future<void> initialize() async {
    if (_logTree == null) {
      _deviceInfo = await DeviceInfo.create();
      _logTree = LogsTree(_deviceInfo!);
      _logTree?.log(LogLevel.info, "initilize()",
          "Initializing logging in debug mode", null);
    }
  }

  static void log(
      LogLevel logLevel, String tag, String message, dynamic error) {
    _logTree?.log(logLevel, tag, message, error);
  }
}
