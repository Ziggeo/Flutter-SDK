import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/recorder/recorder_listener.dart';

import 'stop_recording_confirmation_dialog_config.dart';

class RecorderConfig extends BaseConfig {
  static const defaultStartDelay = 3; // seconds
  static const qualityHigh = 0;
  static const qualityMedium = 1;
  static const qualityLow = 2;
  static const facingBack = 0;
  static const facingFront = 1;

  bool? shouldShowFaceOutline;
  bool? isLiveStreaming;
  bool? shouldAutoStartRecording;
  int? startDelay;
  bool? blurMode;
  bool? shouldSendImmediately;
  bool? shouldDisableCameraSwitch;
  int? videoQuality;
  int? facing;
  int? maxDuration;
  bool? shouldEnableCoverShot;
  bool? shouldConfirmStopRecording;
  bool? isPausedMode;
  StopRecordingConfirmationDialogConfig? stopRecordingConfirmationDialogConfig;
  RecorderEventsListener? eventsListener;

  RecorderConfig({
    this.shouldShowFaceOutline = false,
    this.isLiveStreaming = false,
    this.shouldAutoStartRecording = false,
    this.startDelay = defaultStartDelay,
    this.blurMode = false,
    this.shouldSendImmediately = true,
    this.shouldDisableCameraSwitch = false,
    this.videoQuality = 0,
    this.facing = 0,
    this.maxDuration = 0,
    this.shouldEnableCoverShot = true,
    this.shouldConfirmStopRecording = true,
    this.isPausedMode = true,
    StopRecordingConfirmationDialogConfig?
        stopRecordingConfirmationDialogConfig,
    RecorderEventsListener? eventsListener,
  });

  RecorderConfig convertFromMap(Map<String, dynamic> map) {
    shouldShowFaceOutline = map["shouldShowFaceOutline"];
    isLiveStreaming = map["isLiveStreaming"];
    shouldAutoStartRecording = map["shouldAutoStartRecording"];
    startDelay = map["startDelay"];
    blurMode = map["blurMode"];
    shouldSendImmediately = map["shouldSendImmediately"];
    shouldDisableCameraSwitch = map["shouldDisableCameraSwitch"];
    videoQuality = map["videoQuality"];
    facing = map["facing"];
    maxDuration = map["maxDuration"];
    shouldEnableCoverShot = map["shouldEnableCoverShot"];
    shouldConfirmStopRecording = map["shouldConfirmStopRecording"];
    stopRecordingConfirmationDialogConfig =
        map["stopRecordingConfirmationDialogConfig"];
    isPausedMode = map["isPausedMode"];
    return RecorderConfig(
      shouldShowFaceOutline: shouldShowFaceOutline,
      isLiveStreaming: isLiveStreaming,
      shouldAutoStartRecording: shouldAutoStartRecording,
      startDelay: startDelay,
      blurMode: blurMode,
      shouldSendImmediately: shouldSendImmediately,
      shouldDisableCameraSwitch: shouldDisableCameraSwitch,
      videoQuality: videoQuality,
      facing: facing,
      maxDuration: maxDuration,
      shouldEnableCoverShot: shouldEnableCoverShot,
      shouldConfirmStopRecording: shouldConfirmStopRecording,
      stopRecordingConfirmationDialogConfig:
          stopRecordingConfirmationDialogConfig,
      isPausedMode: isPausedMode,
    );
  }

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldShowFaceOutline"] = shouldShowFaceOutline;
    map["isLiveStreaming"] = isLiveStreaming;
    map["shouldAutoStartRecording"] = shouldAutoStartRecording;
    map["startDelay"] = startDelay;
    map["blurMode"] = blurMode;
    map["shouldSendImmediately"] = shouldSendImmediately;
    map["shouldDisableCameraSwitch"] = shouldDisableCameraSwitch;
    map["videoQuality"] = videoQuality;
    map["facing"] = facing;
    map["maxDuration"] = maxDuration;
    map["shouldEnableCoverShot"] = shouldEnableCoverShot;
    map["shouldConfirmStopRecording"] = shouldConfirmStopRecording;
    map["stopRecordingConfirmationDialogConfig"] =
        stopRecordingConfirmationDialogConfig;
    map["isPausedMode"] = isPausedMode;
    return map;
  }
}
