/// A class representing a remote log entry.
class RemoteLog {
  /// The level of the log (e.g., DEBUG, INFO, WARN, ERROR).
  String logLevel;

  /// An optional tag associated with the log entry.
  String? tag;

  /// The log message.
  String message;

  /// An optional throwable associated with the log entry, typically used for error logs.
  String? throwable;

  /// The time when the log entry was created.
  final String time;

  /// Creates an instance of [RemoteLog] with the given properties.
  RemoteLog({
    required this.logLevel,
    this.tag,
    required this.message,
    this.throwable,
    required this.time,
  });

  /// Converts the [RemoteLog] instance to a JSON object.
  Map<String, dynamic> toJson() => {
        'logLevel': logLevel,
        'tag': tag,
        'message': message,
        'throwable': throwable,
        'time': time,
      };

  @override
  String toString() {
    return 'RemoteLog(logLevel: $logLevel, tag: $tag, message: $message, throwable: $throwable, time: $time)';
  }
}
