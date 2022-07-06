import 'dart:convert';

import 'package:ziggeo_example/screens/recordings/recording_model.dart';

class ImageRecordingModel {
  RecordingModel image;

  ImageRecordingModel({required this.image});

  factory ImageRecordingModel.fromJson(Map<String, dynamic> json) {
    return ImageRecordingModel(
      image: json['image'],
    );
  }

  factory ImageRecordingModel.create(RecordingModel image) {
    return ImageRecordingModel(
      image: image,
    );
  }

  String toJson() {
    Map<String, dynamic> map = Map();
    map['image'] = image.toJson();
    return jsonEncode(map);
  }
}
