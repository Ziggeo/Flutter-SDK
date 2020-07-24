class Logger {
  static List<LogModel> buffer = List();
}

class LogModel {
  String name;
  String details;
  int timestamp;

  @override
  String toString() {
    return 'LogModel{name: $name, details: $details, timestamp: $timestamp}';
  }

  LogModel({this.name, this.details}) {
    timestamp = DateTime.now().millisecondsSinceEpoch;
  }
}
