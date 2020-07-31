import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/file_selector/file_selector_listener.dart';

class FileSelectorConfig extends BaseConfig {
  var maxDuration = 0;
  var shouldAllowMultipleSelection = false;

  FileSelectorEventsListener eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["maxDuration"] = maxDuration;
    map["shouldAllowMultipleSelection"] = shouldAllowMultipleSelection;
    return map;
  }
}
