import 'dart:convert';

import 'package:ziggeo_example/screens/recordings/recording_model.dart';

class AudioRecordingModel {
  RecordingModel audio;

  AudioRecordingModel({required this.audio});

  factory AudioRecordingModel.fromJson(Map<String, dynamic> json) {
    return AudioRecordingModel(
      audio: json['audio'],
    );
  }

  factory AudioRecordingModel.create(RecordingModel audio) {
    return AudioRecordingModel(
      audio: audio,
    );
  }

  String toJson() {
    Map<String, dynamic> map = Map();
    map['audio'] = audio.toJson();
    return jsonEncode(map);
  }
}
