class RecordingModel {
  static const String status_empty = "EMPTY";
  static const String status_verified = "VERIFIED";
  static const String status_processing = "PROCESSING";
  static const String status_failed = "FAILED";
  static const String status_ready = "READY";

  String token;
  String key;
  String state;
  String title;
  String description;
  List<String> tags;
  int created;

  RecordingModel(
      {this.token,
      this.key,
      this.state,
      this.title,
      this.description,
      this.tags,
      this.created});

  factory RecordingModel.fromJson(Map<String, dynamic> json) {
    return RecordingModel(
      token: json['token'],
      key: json['key'],
      state: json['state_string'],
      title: json['title'],
      description: json['description'],
      tags: json['tags']?.cast<String>(),
      created: json['created'],
    );
  }
}
