class BaseStyle {
  var hideControls = false;

  Map<String, dynamic> convertToMap() {
    var map = Map<String, dynamic>();
    map["hideControls"] = hideControls;
    return map;
  }
}
