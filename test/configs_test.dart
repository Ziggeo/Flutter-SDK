import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/recorder/stop_recording_confirmation_dialog_config.dart';
import 'package:ziggeo/styles/camera_recorder.dart';
import 'package:ziggeo/styles/player.dart';
import 'package:ziggeo/ziggeo.dart';

void main() {
  const MessageCodec<String?> string = StringCodec();
  late QrScannerConfig qrScannerConfig;
  late PlayerStyle playerStyle;
  late CameraRecorderStyle cameraRecorderStyle;
  late RecorderConfig recorderConfig;
  late PlayerConfig playerConfig;
  late StopRecordingConfirmationDialogConfig
  stopRecordingConfirmationDialogConfig;
  late FileSelectorConfig fileSelectorConfig;
  late Ziggeo ziggeo;

  TestWidgetsFlutterBinding.ensureInitialized();
  const MessageCodec<dynamic> jsonMessage = JSONMessageCodec();
  const MethodCodec jsonMethod = JSONMethodCodec();
  const MethodChannel channel = MethodChannel('ZiggeoMainMethodChannel', jsonMethod);

  setUp(() {
    playerConfig = PlayerConfig();
    playerStyle = PlayerStyle();
    recorderConfig = RecorderConfig();
    cameraRecorderStyle = CameraRecorderStyle();
    stopRecordingConfirmationDialogConfig =
        StopRecordingConfirmationDialogConfig();
    fileSelectorConfig = FileSelectorConfig();
    qrScannerConfig = QrScannerConfig();

    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMessageHandler(
      'ziggeo',
          (ByteData? message) async
          {
        final Map<dynamic, dynamic> methodCall = jsonMessage.decodeMessage(message) as Map<dynamic, dynamic>;
        if (methodCall['method'] == 'setAppToken') {
          return jsonMessage.encodeMessage(<dynamic>[{methodCall['appToken']}]);
        } else {
          return jsonMessage.encodeMessage(<dynamic>['unknown', null, null]);
        }
      },
    );
    ziggeo = Ziggeo('token');
  });

  tearDown(() {});

  test('playerConfig_isMuted', () async {
    expect(playerConfig.convertToMap()["isMuted"], false);
    playerConfig.isMuted = true;
    expect(playerConfig.convertToMap()["isMuted"], true);
  });

  test('playerConfig_showSubtitles', () async {
    expect(playerConfig.convertToMap()["shouldShowSubtitles"], false);
    playerConfig.shouldShowSubtitles = true;
    expect(playerConfig.convertToMap()["shouldShowSubtitles"], true);
  });

  test('playerConfig_style', () async {
    expect(playerConfig.convertToMap()["playerStyle"], null);
    playerConfig.playerStyle = PlayerStyle();
    expect(playerConfig.convertToMap()["playerStyle"], isNotNull);
  });

  test('playerStyle_controllerStyle', () async {
    expect(playerStyle.convertToMap()["controllerStyle"], PlayerStyle.DEFAULT);
    playerStyle.controllerStyle = PlayerStyle.CUBE;
    expect(playerStyle.convertToMap()["controllerStyle"], PlayerStyle.CUBE);
  });

  test('playerStyle_textColor', () async {
    expect(playerStyle.convertToMap()["textColor"], null);
    playerStyle.textColor = Colors.amber.value;
    expect(playerStyle.convertToMap()["textColor"], Colors.amber.value);
  });

  test('playerStyle_unplayedColor', () async {
    expect(playerStyle.convertToMap()["unplayedColor"], null);
    playerStyle.unplayedColor = Colors.amber.value;
    expect(playerStyle.convertToMap()["unplayedColor"], Colors.amber.value);
  });
  test('playerStyle_playedColor', () async {
    expect(playerStyle.convertToMap()["playedColor"], null);
    playerStyle.playedColor = Colors.amber.value;
    expect(playerStyle.convertToMap()["playedColor"], Colors.amber.value);
  });
  test('playerStyle_bufferedColor', () async {
    expect(playerStyle.convertToMap()["bufferedColor"], null);
    playerStyle.bufferedColor = Colors.amber.value;
    expect(playerStyle.convertToMap()["bufferedColor"], Colors.amber.value);
  });
  test('playerStyle_tintColor', () async {
    expect(playerStyle.convertToMap()["tintColor"], null);
    playerStyle.tintColor = Colors.amber.value;
    expect(playerStyle.convertToMap()["tintColor"], Colors.amber.value);
  });
  test('playerStyle_muteOffImageDrawable', () async {
    expect(playerStyle.convertToMap()["muteOffImageDrawable"], null);
    playerStyle.muteOffImageDrawable = PlayerStyle.CUBE;
    expect(
        playerStyle.convertToMap()["muteOffImageDrawable"], PlayerStyle.CUBE);
  });
  test('playerStyle_muteOnImageDrawable', () async {
    expect(playerStyle.convertToMap()["muteOnImageDrawable"], null);
    playerStyle.muteOnImageDrawable = PlayerStyle.CUBE;
    expect(playerStyle.convertToMap()["muteOnImageDrawable"], PlayerStyle.CUBE);
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
    expect(recorderConfig.convertToMap()["shouldShowFaceOutline"], false);
    recorderConfig.shouldShowFaceOutline = true;
    expect(recorderConfig.convertToMap()["shouldShowFaceOutline"], true);
  });

  test('recorderConfig_isLiveStreaming', () async {
    expect(recorderConfig.convertToMap()["isLiveStreaming"], false);
    recorderConfig.isLiveStreaming = true;
    expect(recorderConfig.convertToMap()["isLiveStreaming"], true);
  });

  test('recorderConfig_autostart', () async {
    expect(recorderConfig.convertToMap()["shouldAutoStartRecording"], false);
    recorderConfig.shouldAutoStartRecording = true;
    expect(recorderConfig.convertToMap()["shouldAutoStartRecording"], true);
  });

  test('recorderConfig_startDelay', () async {
    expect(recorderConfig.convertToMap()["startDelay"],
        RecorderConfig.defaultStartDelay);
    recorderConfig.startDelay = 4;
    expect(recorderConfig.convertToMap()["startDelay"], 4);
  });

  test('recorderConfig_blurMode', () async {
    expect(recorderConfig.convertToMap()["blurMode"], false);
    recorderConfig.blurMode = true;
    expect(recorderConfig.convertToMap()["blurMode"], true);
  });

  test('recorderConfig_sendImmediately', () async {
    expect(recorderConfig.convertToMap()["shouldSendImmediately"], true);
    recorderConfig.shouldSendImmediately = false;
    expect(recorderConfig.convertToMap()["shouldSendImmediately"], false);
  });

  test('recorderConfig_disableCameraSwitch', () async {
    expect(recorderConfig.convertToMap()["shouldDisableCameraSwitch"], false);
    recorderConfig.shouldDisableCameraSwitch = true;
    expect(recorderConfig.convertToMap()["shouldDisableCameraSwitch"], true);
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
    expect(recorderConfig.convertToMap()["shouldEnableCoverShot"], true);
    recorderConfig.shouldEnableCoverShot = false;
    expect(recorderConfig.convertToMap()["shouldEnableCoverShot"], false);
  });

  test('recorderConfig_confirmStopRecording', () async {
    expect(recorderConfig.convertToMap()["shouldConfirmStopRecording"], true);
    recorderConfig.shouldConfirmStopRecording = false;
    expect(recorderConfig.convertToMap()["shouldConfirmStopRecording"], false);
  });

  test('recorderConfig_stopRecordingConfirmationDialogConfig', () async {
    expect(
        recorderConfig.convertToMap()["stopRecordingConfirmationDialogConfig"],
        null);
    recorderConfig.stopRecordingConfirmationDialogConfig =
        StopRecordingConfirmationDialogConfig();
    expect(
        recorderConfig.convertToMap()["stopRecordingConfirmationDialogConfig"],
        isNotNull);
  });

  //stopRecordingConfirmationDialogConfig
  test('stopRecordingConfirmationDialogConfig_titleResId', () async {
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["titleResId"],
        null);
    stopRecordingConfirmationDialogConfig.titleResId = 1;
    expect(
        stopRecordingConfirmationDialogConfig.convertToMap()["titleResId"], 1);
  });

  test('stopRecordingConfirmationDialogConfig_titleText', () async {
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["titleText"],
        null);
    stopRecordingConfirmationDialogConfig.titleText = Characters("text");
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["titleText"],
        Characters("text"));
  });

  test('stopRecordingConfirmationDialogConfig_mesText', () async {
    expect(
        stopRecordingConfirmationDialogConfig.convertToMap()["mesText"], null);
    stopRecordingConfirmationDialogConfig.mesText = Characters("mesText");
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["mesText"],
        Characters("mesText"));
  });

  test('stopRecordingConfirmationDialogConfig_posBtnText', () async {
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["posBtnText"],
        null);
    stopRecordingConfirmationDialogConfig.posBtnText = Characters("posBtnText");
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["posBtnText"],
        Characters("posBtnText"));
  });

  test('stopRecordingConfirmationDialogConfig_negBtnText', () async {
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["negBtnText"],
        null);
    stopRecordingConfirmationDialogConfig.negBtnText = Characters("negBtnText");
    expect(stopRecordingConfirmationDialogConfig.convertToMap()["negBtnText"],
        Characters("negBtnText"));
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

  test('fileSelectorConfig_maxDuration', () async {
    expect(fileSelectorConfig.convertToMap()["maxDuration"], 0);
    fileSelectorConfig.maxDuration = 4;
    expect(fileSelectorConfig.convertToMap()["maxDuration"], 4);
  });

  test('fileSelectorConfig_shouldAllowMultipleSelection', () async {
    expect(fileSelectorConfig.convertToMap()["shouldAllowMultipleSelection"],
        false);
    fileSelectorConfig.shouldAllowMultipleSelection = true;
    expect(fileSelectorConfig.convertToMap()["shouldAllowMultipleSelection"],
        true);
  });

  test('fileSelectorConfig_mediaType', () async {
    expect(fileSelectorConfig.convertToMap()["mediaType"],
        FileSelectorConfig.videoMediaType);
    fileSelectorConfig.mediaType = FileSelectorConfig.audioMediaType;
    expect(fileSelectorConfig.convertToMap()["mediaType"],
        FileSelectorConfig.audioMediaType);
  });

  test('qrScannerConfig_mediaType', () async {
    expect(
        qrScannerConfig.convertToMap()["shouldCloseAfterSuccessfulScan"], true);
    qrScannerConfig.shouldCloseAfterSuccessfulScan = false;
    expect(qrScannerConfig.convertToMap()["shouldCloseAfterSuccessfulScan"],
        false);
  });

  test("Listening device", ()
  async {
    // ServicesBinding.instance?.defaultBinaryMessenger.handlePlatformMessage(
    //     'ZiggeoMainMethodChannel',
    //     StandardMethodCodec().encodeMethodCall(
    //         MethodCall('getAppToken', '{"result":"token"}')), (ByteData? data) {
    //   string.encodeMessage(string.decodeMessage(data));
    //   });


    TestDefaultBinaryMessengerBinding.instance!.defaultBinaryMessenger.setMockMessageHandler(
      'ZiggeoMainMethodChannel',
          (ByteData? message) async {
        final Map<dynamic, dynamic> methodCall = jsonMessage.decodeMessage(message) as Map<dynamic, dynamic>;
        if (methodCall['method'] == 'getAppToken') {
          return jsonMessage.encodeMessage(<dynamic>[{methodCall['appToken']}]);
        } else {
          return jsonMessage.encodeMessage(<dynamic>['unknown', null, null]);
        }
      },
    );
    final String? result = await channel.invokeMethod('getAppToken', 'hello');

    expect(result, equals('hello'));
  });
}
