import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/uploading/uploading_listener.dart';

class UploadingConfig extends BaseConfig {
  static const defaultSyncInterval = 2 * 60 * 60 * 1000; // 2 hours

  bool? shouldUseWifiOnly;
  int? syncInterval;
  bool? shouldTurnOffUploader;

  UploadingEventsListener? eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldUseWifiOnly"] = shouldUseWifiOnly;
    map["syncInterval"] = syncInterval;
    map["shouldTurnOffUploader"] = shouldTurnOffUploader;
    return map;
  }

  UploadingConfig({
    this.shouldUseWifiOnly = false,
    this.syncInterval = defaultSyncInterval,
    this.shouldTurnOffUploader = false,
  });

  UploadingConfig convertFromMap(Map<String, dynamic> map) {
    shouldUseWifiOnly = map["shouldUseWifiOnly"];
    syncInterval = map["syncInterval"];
    shouldTurnOffUploader = map["shouldTurnOffUploader"];
    return UploadingConfig(
      shouldUseWifiOnly: shouldUseWifiOnly,
      syncInterval: syncInterval,
      shouldTurnOffUploader: shouldTurnOffUploader,
    );
  }
}
