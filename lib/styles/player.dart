import 'package:ziggeo/common/base_style.dart';

class PlayerStyle extends BaseStyle {

  static const DEFAULT = 0;
  static const MODERN = 1;
  static const CUBE = 2;
  static const SPACE = 3;
  static const MINIMALIST = 4;
  static const ELEVATE = 5;
  static const THEATRE = 6;

  int? controllerStyle;
  int? textColor;
  int? unplayedColor;
  int? playedColor;
  int? bufferedColor;
  int? tintColor;
  int? muteOffImageDrawable;
  int? muteOnImageDrawable;

  PlayerStyle({
    this.controllerStyle = DEFAULT,
    this.textColor,
    this.unplayedColor,
    this.playedColor,
    this.bufferedColor,
    this.tintColor,
    this.muteOffImageDrawable,
    this.muteOnImageDrawable,
  });

  PlayerStyle convertFromMap(Map<String, dynamic> map) {
    controllerStyle = map["controllerStyle"];
    textColor = map["textColor"];
    unplayedColor = map["unplayedColor"];
    playedColor = map["playedColor"];
    bufferedColor = map["bufferedColor"];
    tintColor = map["tintColor"];
    muteOffImageDrawable = map["muteOffImageDrawable"];
    muteOnImageDrawable = map["muteOnImageDrawable"];
    return PlayerStyle(
      controllerStyle: controllerStyle,
      textColor: textColor,
      unplayedColor: unplayedColor,
      playedColor: playedColor,
      bufferedColor: bufferedColor,
      tintColor: tintColor,
      muteOffImageDrawable: muteOffImageDrawable,
      muteOnImageDrawable: muteOnImageDrawable,
    );
  }

  Map<String, dynamic> convertToMap() {
    var map = super.convertToMap();
    map["controllerStyle"] = controllerStyle;
    map["textColor"] = textColor;
    map["unplayedColor"] = unplayedColor;
    map["playedColor"] = playedColor;
    map["bufferedColor"] = bufferedColor;
    map["tintColor"] = tintColor;
    map["muteOffImageDrawable"] = muteOffImageDrawable;
    map["muteOnImageDrawable"] = muteOnImageDrawable;
    return map;
  }
}
