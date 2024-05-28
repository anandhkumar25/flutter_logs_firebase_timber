import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_logs_firebase_timber/remote/remote_log.dart';
import 'package:intl/intl.dart';
import '../models/device_info.dart';

class LogsTree {
  final DeviceInfo deviceInfo;
  final String date;
  final DatabaseReference logRef;
  final DateFormat timeFormat = DateFormat('yyyy-MM-dd hh:mm:ss.SSS a zzz');

  LogsTree(this.deviceInfo)
      : date = DateFormat('dd-MM-yyyy').format(DateTime.now()),
        logRef = FirebaseDatabase.instance
            .ref()
            .child('logs')
            .child(DateFormat('dd-MM-yyyy').format(DateTime.now()))
            .child(deviceInfo.deviceId?.replaceAll(".", "_") ??
                deviceInfo.deviceName);

  /// - Parameters:
  ///   - logLevel: The level of the log message (e.g., verbose, debug, info, warning, error).
  ///   - tag: A tag used to identify the source of the log message (e.g., the class or method name).
  ///   - message: The log message to be recorded.
  ///   - error: An optional error object to include additional error details in the log.
  ///
  void log(LogLevel logLevel, String? tag, String message, [Throwable? t]) {
    if (BuildConfig.remoteLogsEnabled) {
      final now = DateTime.now();
      final remoteLog = RemoteLog(
        logLevel: _logLevelToString(logLevel),
        tag: tag,
        message: message,
        throwable: t?.toString(),
        time: timeFormat.format(now),
      );

      final updates = {
        '-DeviceDetails': deviceInfo.toJson(),
        now.millisecondsSinceEpoch.toString(): remoteLog.toJson()
      };
      logRef.update(updates);
    } else {
      _consoleLogcat(logLevel, message);
    }
  }
}

enum LogLevel { verbose, debug, info, warning, error }

String _logLevelToString(LogLevel level) {
  switch (level) {
    case LogLevel.verbose:
      return 'VERBOSE';
    case LogLevel.debug:
      return 'DEBUG';
    case LogLevel.info:
      return 'INFO';
    case LogLevel.warning:
      return 'WARNING';
    case LogLevel.error:
      return 'ERROR';
    default:
      return 'UNKNOWN';
  }
}

void _consoleLogcat(LogLevel logLevel, String message,
    [dynamic error, StackTrace? stackTrace]) {
  if (logLevel.index > logLevel.index) return;
  onMessage(logLevel, message, error: error, stackTrace: stackTrace);
}

/// Logs a verbose message.
///
/// [message]: The message to log.
void v(String message) => _consoleLogcat(LogLevel.verbose, message);

/// Logs a debug message.
///
/// [message]: The message to log.
void d(String message) => _consoleLogcat(LogLevel.debug, message);

/// Logs an informational message.
///
/// [message]: The message to log.
void i(String message) => _consoleLogcat(LogLevel.info, message);

/// Logs a warning message.
///
/// [message]: The message to log.
void w(String message) => _consoleLogcat(LogLevel.warning, message);

/// Logs an error message.
///
/// [message]: The message to log.
/// [error]: Optional error associated with the log message.
/// [stackTrace]: Optional stack trace associated with the error.
void e(String message, {dynamic error, StackTrace? stackTrace}) =>
    _consoleLogcat(LogLevel.error, message, error, stackTrace);

void onMessage(
  LogLevel logLevel,
  String message, {
  String? tag,
  dynamic error,
  StackTrace? stackTrace,
}) {
  String time = DateFormat('dd-MM-yyyy').format(DateTime.now());
  tag = tag ?? _getFileTag();
  String prefix = '[$time][$tag]';
  message = '${_getLogEmoji(logLevel)} $message';
  debugPrint('$prefix $message');
  if (stackTrace != null) {
    _debugPrintStack(logLevel, stackTrace);
  }
}

class BuildConfig {
  static bool remoteLogsEnabled = true;
}

String _getFileTag() => _GetStackTrace(StackTrace.current).fileName;

String _colourize(int color, String text) => '\x1B[3${color}m$text\x1B[0m';

String _getLogEmoji(LogLevel logLevel) {
  switch (logLevel) {
    case LogLevel.warning:
      return '⚠️';
    case LogLevel.error:
      return '⛔';
    case LogLevel.info:
      return '💡';
    case LogLevel.debug:
      return '🐛';
    default:
      return '';
  }
}

void _debugPrintStack(LogLevel logLevel, StackTrace stackTrace) {
  stackTrace = FlutterError.demangleStackTrace(stackTrace);

  Iterable<String> lines = stackTrace.toString().trimRight().split('\n');
  if (kIsWeb && lines.isNotEmpty) {
    lines = lines.skipWhile((String line) =>
        line.contains('StackTrace.current') ||
        line.contains('dart-sdk/lib/_internal') ||
        line.contains('dart:sdk_internal'));
  }

  int color;
  const int yellow = 3;
  const int grey = 8;
  const int red = 1;
  switch (logLevel) {
    case LogLevel.warning:
      color = yellow;
      break;
    case LogLevel.error:
      color = red;
      break;
    default:
      color = grey;
  }

  debugPrint(
    _colourize(
      color,
      FlutterError.defaultStackFilter(lines).join('\n'),
    ),
  );
}

class Throwable {
  final String message;
  Throwable(this.message);

  @override
  String toString() => message;
}

class _GetStackTrace {
  final StackTrace _trace;
  late final String fullFileName;
  late final String fileName;
  late final int lineNumber;
  late final int columnNumber;

  _GetStackTrace(this._trace) {
    var traceString = _trace.toString().split("\n")[3];
    var indexOfFileName = traceString.indexOf(RegExp(r'[A-Za-z_]+\.dart'));
    var listOfInfos = traceString.substring(indexOfFileName).split(":");
    fileName = listOfInfos[0].replaceAll('.dart', '');
    lineNumber = int.parse(listOfInfos[1]);
    columnNumber = int.parse(listOfInfos[2].replaceFirst(")", ""));
  }
}
