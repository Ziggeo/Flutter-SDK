import 'package:ziggeo/common/base_config.dart';
import 'package:ziggeo/player/player_listener.dart';
import 'package:ziggeo/styles/player.dart';

class PlayerConfig extends BaseConfig {
  bool? shouldShowSubtitles;
  bool? isMuted;
  PlayerEventsListener? eventsListener;
  PlayerStyle? playerStyle;

  @override
  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["shouldShowSubtitles"] = shouldShowSubtitles;
    map["isMuted"] = isMuted;
    map["playerStyle"] = playerStyle;
    return map;
  }

  PlayerConfig convertFromMap(Map<String, dynamic> map) {
    shouldShowSubtitles = map["shouldShowSubtitles"];
    isMuted = map["isMuted"];
    playerStyle = map["playerStyle"];
    return PlayerConfig(
      shouldShowSubtitles: shouldShowSubtitles,
      isMuted: isMuted,
      playerStyle: playerStyle,
    );
  }

  PlayerConfig({
    this.shouldShowSubtitles = false,
    this.isMuted = false,
    this.playerStyle,
  });
}
