import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/file_selector/file_selector_listener.dart';

class FileSelectorConfig extends BaseConfig {
  static const videoMediaType = 0x01;
  static const audioMediaType = 0x02;
  static const imageMediaType = 0x04;

  var maxDuration = 0;
  var shouldAllowMultipleSelection = false;
  var mediaType = videoMediaType;

  FileSelectorEventsListener? eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["maxDuration"] = maxDuration;
    map["shouldAllowMultipleSelection"] = shouldAllowMultipleSelection;
    map["mediaType"] = mediaType;
    return map;
  }
}
