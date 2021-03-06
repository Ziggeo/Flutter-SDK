import 'package:flutter_test/flutter_test.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/styles/camera_recorder.dart';
import 'package:ziggeo/styles/player.dart';

void main() {
  PlayerStyle playerStyle;
  CameraRecorderStyle cameraRecorderStyle;
  RecorderConfig recorderConfig;
  PlayerConfig playerConfig;

  setUp(() {
    playerConfig = PlayerConfig();
    playerStyle = PlayerStyle();
    recorderConfig = RecorderConfig();
    cameraRecorderStyle = CameraRecorderStyle();
  });

  tearDown(() {});

  test('playerConfig_isMuted', () async {
    expect(playerConfig.convertToMap()["muted"], false);
    playerConfig.isMuted = true;
    expect(playerConfig.convertToMap()["muted"], true);
  });

  test('playerConfig_showSubtitles', () async {
    expect(playerConfig.convertToMap()["showSubtitles"], false);
    playerConfig.shouldShowSubtitles = true;
    expect(playerConfig.convertToMap()["showSubtitles"], true);
  });

  test('playerConfig_style', () async {
    expect(playerConfig.convertToMap()["style"], null);
    playerConfig.style = PlayerStyle();
    expect(playerConfig.convertToMap()["style"], isNotNull);
  });

  test('playerConfig_extraArgs', () async {
    expect(playerConfig.convertToMap()["extraArgs"]["tags"], null);
    playerConfig.extraArgs = {"tags": "test_tag"};
    expect(playerConfig.convertToMap()["extraArgs"]["tags"], "test_tag");
  });

  test('playerStyle_hideControls', () async {
    expect(playerStyle.convertToMap()["hideControls"], false);
    playerStyle.hideControls = true;
    expect(playerStyle.convertToMap()["hideControls"], true);
  });

  test('cameraRecorderStyle_hideControls', () async {
    expect(cameraRecorderStyle.convertToMap()["hideControls"], false);
    cameraRecorderStyle.hideControls = true;
    expect(cameraRecorderStyle.convertToMap()["hideControls"], true);
  });

  test('recorderConfig_showFaceOutline', () async {
    expect(recorderConfig.convertToMap()["showFaceOutline"], false);
    recorderConfig.shouldShowFaceOutline = true;
    expect(recorderConfig.convertToMap()["showFaceOutline"], true);
  });

  test('recorderConfig_autostart', () async {
    expect(recorderConfig.convertToMap()["autostart"], false);
    recorderConfig.shouldAutoStartRecording = true;
    expect(recorderConfig.convertToMap()["autostart"], true);
  });

  test('recorderConfig_startDelay', () async {
    expect(recorderConfig.convertToMap()["startDelay"],
        RecorderConfig.defaultStartDelay);
    recorderConfig.startDelay = 1;
    expect(recorderConfig.convertToMap()["startDelay"], 1);
  });

  test('recorderConfig_sendImmediately', () async {
    expect(recorderConfig.convertToMap()["sendImmediately"], true);
    recorderConfig.shouldSendImmediately = false;
    expect(recorderConfig.convertToMap()["sendImmediately"], false);
  });

  test('recorderConfig_disableCameraSwitch', () async {
    expect(recorderConfig.convertToMap()["disableCameraSwitch"], false);
    recorderConfig.shouldDisableCameraSwitch = true;
    expect(recorderConfig.convertToMap()["disableCameraSwitch"], true);
  });

  test('recorderConfig_videoQuality', () async {
    expect(recorderConfig.convertToMap()["videoQuality"], 0);
    recorderConfig.videoQuality = 1;
    expect(recorderConfig.convertToMap()["videoQuality"], 1);
  });

  test('recorderConfig_facing', () async {
    expect(recorderConfig.convertToMap()["facing"], 0);
    recorderConfig.facing = 1;
    expect(recorderConfig.convertToMap()["facing"], 1);
  });

  test('recorderConfig_maxDuration', () async {
    expect(recorderConfig.convertToMap()["maxDuration"], 0);
    recorderConfig.maxDuration = 1;
    expect(recorderConfig.convertToMap()["maxDuration"], 1);
  });

  test('recorderConfig_enableCoverShot', () async {
    expect(recorderConfig.convertToMap()["enableCoverShot"], true);
    recorderConfig.shouldEnableCoverShot = false;
    expect(recorderConfig.convertToMap()["enableCoverShot"], false);
  });

  test('recorderConfig_confirmStopRecording', () async {
    expect(recorderConfig.convertToMap()["confirmStopRecording"], false);
    recorderConfig.shouldConfirmStopRecording = true;
    expect(recorderConfig.convertToMap()["confirmStopRecording"], true);
  });

  test('recorderConfig_style', () async {
    expect(recorderConfig.convertToMap()["style"], null);
    recorderConfig.style = CameraRecorderStyle();
    expect(recorderConfig.convertToMap()["style"], isNotNull);
  });

  test('recorderConfig_extraArgs', () async {
    expect(recorderConfig.convertToMap()["extraArgs"]["tags"], null);
    recorderConfig.extraArgs = {"tags": "test_tag"};
    expect(recorderConfig.convertToMap()["extraArgs"]["tags"], "test_tag");
  });
}
