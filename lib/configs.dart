import 'package:ziggeo/listeners.dart';

abstract class BaseConfig {
  var style;
  var extraArgs = Map<String, dynamic>();

  Map<String, dynamic> convertToMap() {
    var map = Map<String, dynamic>();
    map["style"] = style;
    map["extraArgs"] = extraArgs;
    return map;
  }
}

class RecorderConfig extends BaseConfig {
  static const defaultStartDelay = 3; // seconds
  static const qualityHigh = 0;
  static const qualityMedium = 1;
  static const qualityLow = 2;

  static const facingBack = 0;
  static const facingFront = 1;

  var shouldShowFaceOutline = false;
  var isLiveStreaming = false;
  var shouldAutoStartRecording = false;
  var startDelay = defaultStartDelay;
  var shouldSendImmediately = true;
  var shouldDisableCameraSwitch = false;
  var videoQuality = 0;
  var facing = 0;
  var maxDuration = 0;
  var shouldEnableCoverShot = true;
  var shouldConfirmStopRecording = false;

  RecorderEventsListener eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldShowFaceOutline"] = shouldShowFaceOutline;
    map["isLiveStreaming"] = isLiveStreaming;
    map["shouldAutoStartRecording"] = shouldAutoStartRecording;
    map["startDelay"] = startDelay;
    map["shouldSendImmediately"] = shouldSendImmediately;
    map["shouldDisableCameraSwitch"] = shouldDisableCameraSwitch;
    map["videoQuality"] = videoQuality;
    map["facing"] = facing;
    map["maxDuration"] = maxDuration;
    map["shouldEnableCoverShot"] = shouldEnableCoverShot;
    map["shouldConfirmStopRecording"] = shouldConfirmStopRecording;
    return map;
  }
}

class PlayerConfig extends BaseConfig {
  var showSubtitles = false;
  var muted = false;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["showSubtitles"] = showSubtitles;
    map["muted"] = muted;
    return map;
  }
}

class BaseStyle {
  var hideControls = false;

  Map<String, dynamic> convertToMap() {
    var map = Map<String, dynamic>();
    map["hideControls"] = hideControls;
    return map;
  }
}

class CameraRecorderStyle extends BaseStyle {}

class PlayerStyle extends BaseStyle {}
