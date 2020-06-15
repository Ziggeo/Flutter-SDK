import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/player/player_listener.dart';

class PlayerConfig extends BaseConfig {
  var showSubtitles = false;
  var muted = false;

  PlayerEventsListener eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["showSubtitles"] = showSubtitles;
    map["muted"] = muted;
    return map;
  }
}
