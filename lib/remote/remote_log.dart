class RemoteLog {
  String logLevel;
  String? tag;
  String message;
  String? throwable;
  final String time;

  RemoteLog({
    required this.logLevel,
    this.tag,
    required this.message,
    this.throwable,
    required this.time,
  });

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
