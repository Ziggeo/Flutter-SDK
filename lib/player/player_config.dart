import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/player/player_listener.dart';

class PlayerConfig extends BaseConfig {
  var shouldShowSubtitles = false;
  var isMuted = false;

  PlayerEventsListener eventsListener;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldShowSubtitles"] = shouldShowSubtitles;
    map["isMuted"] = isMuted;
    return map;
  }
}
