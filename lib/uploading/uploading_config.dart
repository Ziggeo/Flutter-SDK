import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/uploading/uploading_listener.dart';

class UploadingConfig extends BaseConfig {
  static const defaultSyncInterval = 2 * 60 * 60 * 1000; // 2 hours
  static const UPLOADING_ERROR_ACTION_DELETE_VIDEO = 554;
  static const UPLOADING_ERROR_ACTION_ERROR_NOTIFICATION = 553;
  static const UPLOADING_ERROR_ACTION_RELOAD_VIDEO = 552;
  //todo new release
//   static const CONNECTION_ACTION_CONTINUE_UPLOADING_VIDEO = 551;

  bool? shouldUseWifiOnly;
  int? syncInterval;
  bool? shouldTurnOffUploader;
  int? lostConnectionAction;

  UploadingEventsListener? eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldUseWifiOnly"] = shouldUseWifiOnly;
    map["syncInterval"] = syncInterval;
    map["shouldTurnOffUploader"] = shouldTurnOffUploader;
    map["lostConnectionAction"] = lostConnectionAction;
    return map;
  }

  UploadingConfig({
    this.shouldUseWifiOnly = false,
    this.syncInterval = defaultSyncInterval,
    this.shouldTurnOffUploader = false,
    this.lostConnectionAction = UPLOADING_ERROR_ACTION_ERROR_NOTIFICATION
  });

  UploadingConfig convertFromMap(Map<String, dynamic> map) {
    shouldUseWifiOnly = map["shouldUseWifiOnly"];
    syncInterval = map["syncInterval"];
    shouldTurnOffUploader = map["shouldTurnOffUploader"];
    lostConnectionAction = map["lostConnectionAction"];
    return UploadingConfig(
      shouldUseWifiOnly: shouldUseWifiOnly,
      syncInterval: syncInterval,
      shouldTurnOffUploader: shouldTurnOffUploader,
      lostConnectionAction: lostConnectionAction,
    );
  }
}
