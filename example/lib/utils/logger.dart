class Logger {
  static List<LogModel> buffer = List();
}

class LogModel {
  String name;
  String details;
  int timestamp;

  LogModel({this.name, this.details}) {
    timestamp = DateTime.now().millisecondsSinceEpoch;
  }
}
