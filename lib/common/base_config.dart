abstract class BaseConfig {
  var style;
  var extraArgs = Map<String, dynamic>();

  Map<String, dynamic> convertToMap() {
    var map = Map<String, dynamic>();
    map["style"] = style;
    map["extraArgs"] = extraArgs;
    return map;
  }
}
