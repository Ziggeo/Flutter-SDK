class Logger {
  static List<LogModel> buffer = List.empty();
}

class LogModel {
  String name;
  String? details;
  late int timestamp;

  @override
  String toString() {
    return 'LogModel{name: $name, details: $details, timestamp: $timestamp}';
  }

  LogModel({
    required this.name,
    this.details,
  }) {
    timestamp = DateTime.now().millisecondsSinceEpoch;
  }
}
