abstract class BaseConfig {
  var style;
  var extraArgs = new Map<String, dynamic>();

  Map<String, dynamic> convertToMap() {
    var map = new Map<String, dynamic>();
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

  var showFaceOutline = false;
  var autostart = false;
  var startDelay = defaultStartDelay;
  var sendImmediately = true;
  var disableCameraSwitch = false;
  var videoQuality = 0;
  var facing = 0;
  var maxDuration = 0;
  var enableCoverShot = true;
  var confirmStopRecording = false;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["showFaceOutline"] = showFaceOutline;
    map["autostart"] = autostart;
    map["startDelay"] = startDelay;
    map["sendImmediately"] = sendImmediately;
    map["disableCameraSwitch"] = disableCameraSwitch;
    map["videoQuality"] = videoQuality;
    map["facing"] = facing;
    map["maxDuration"] = maxDuration;
    map["enableCoverShot"] = enableCoverShot;
    map["confirmStopRecording"] = confirmStopRecording;
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
    var map = new Map<String, dynamic>();
    map["hideControls"] = hideControls;
    return map;
  }
}

class CameraRecorderStyle extends BaseStyle {}

class PlayerStyle extends BaseStyle {}
