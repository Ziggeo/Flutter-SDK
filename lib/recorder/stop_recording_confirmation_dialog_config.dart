import 'package:flutter/material.dart';

class StopRecordingConfirmationDialogConfig {
  int? titleResId;
  Characters? titleText;
  int? mesResId;
  Characters? mesText;
  int? posBtnResId;
  Characters? posBtnText;
  int? negBtnResId;
  Characters? negBtnText;

  StopRecordingConfirmationDialogConfig({
    this.titleResId,
    this.titleText,
    this.mesResId,
    this.mesText,
    this.posBtnResId,
    this.posBtnText,
    this.negBtnResId,
    this.negBtnText,
  });

  Map<String, dynamic> convertToMap() {
    var map = Map<String, dynamic>();
    map["titleResId"] = titleResId;
    map["titleText"] = titleText;
    map["mesResId"] = mesResId;
    map["mesText"] = mesText;
    map["posBtnResId"] = posBtnResId;
    map["negBtnResId"] = negBtnResId;
    map["negBtnText"] = negBtnText;
    map["posBtnText"] = posBtnText;
    return map;
  }
}
