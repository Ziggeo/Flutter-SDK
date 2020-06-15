import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/uploading/uploading_listener.dart';

class UploadingConfig extends BaseConfig {
  static const defaultSyncInterval = 2 * 60 * 60 * 1000; // 2 hours

  var shouldUseWifiOnly = false;
  var syncInterval = defaultSyncInterval;
  var shouldTurnOffUploader = false;

  UploadingEventsListener eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldUseWifiOnly"] = shouldUseWifiOnly;
    map["syncInterval"] = syncInterval;
    map["shouldTurnOffUploader"] = shouldTurnOffUploader;
    return map;
  }
}
