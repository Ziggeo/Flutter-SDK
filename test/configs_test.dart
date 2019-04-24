import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo/configs.dart';

void main() {

  var playerStyle;
  var cameraRecorderStyle;
  var recorderConfig;
  var playerConfig;

  setUp(() {
    playerConfig = new PlayerConfig();
    playerStyle = new PlayerStyle();
    recorderConfig = new RecorderConfig();
    cameraRecorderStyle = new CameraRecorderStyle();
  });

  tearDown(() {
  });
}
