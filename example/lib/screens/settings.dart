import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

import '../localization.dart';

class SettingsScreen extends StatefulWidget {
  static const String routeName = 'title_settings';
  Ziggeo ziggeo;

  SettingsScreen(this.ziggeo);

  @override
  _SettingsScreenState createState() => _SettingsScreenState(ziggeo);
}

class _SettingsScreenState extends State<SettingsScreen> {
  final Ziggeo ziggeo;
  AppLocalizations localize = AppLocalizations.instance;

  bool isCustomVideoSwitched = false;
  bool isCustomCameraSwitched = false;
  bool isBlurSwitched = false;
  String startDelay;
  RecorderConfig config;

  _SettingsScreenState(this.ziggeo);

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(common_margin),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (value) => startDelay = value,
                  enabled: true,
                  initialValue: startDelay,
                  style: null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: localize.text('hint_start_delay'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(common_margin),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'tv_custom_video_mode',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: Switch(
                            value: isCustomVideoSwitched,
                            onChanged: (value) {
                              setState(
                                () {
                                  isCustomVideoSwitched = value;
                                },
                              );
                            },
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(common_margin),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'tv_custom_camera_mode',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: isCustomCameraSwitched,
                          onChanged: (value) {
                            setState(
                              () {
                                isCustomCameraSwitched = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(common_margin),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextLocalized(
                        'tv_blur_mode',
                        style: TextStyle(fontSize: message_text_size),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Switch(
                          value: isBlurSwitched,
                          onChanged: (value) {
                            setState(
                              () {
                                isBlurSwitched = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: btn_qr_width,
                height: btn_qr_height,
                child: RaisedButton(
                  onPressed: () {
                    onSavedBtnPressed();
                  },
                  child: TextLocalized('btn_save_settings'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  onSavedBtnPressed() async {
    config = RecorderConfig();

    await SharedPreferences.getInstance().then((value) {
      value.setBool(Utils.keyCustomPlayerMode, isCustomVideoSwitched);
      value.setBool(Utils.keyCustomCameraMode, isCustomCameraSwitched);
      value.setBool(Utils.keyBlurMode, isBlurSwitched);
    });
    if (startDelay != null) {
      config.startDelay = int.parse(startDelay);
      ziggeo.recorderConfig = config;
    }
    if (isBlurSwitched != null) {
      config.blurMode = isBlurSwitched;
      ziggeo.recorderConfig = config;
    }
  }

  init() async {
    await SharedPreferences.getInstance().then((value) {
      setState(() {
        if (value.getBool(Utils.keyCustomPlayerMode) != null) {
          isCustomVideoSwitched = value.getBool(Utils.keyCustomPlayerMode);
        }
        if (value.getBool(Utils.keyCustomPlayerMode) != null) {
          isCustomCameraSwitched = value.getBool(Utils.keyCustomCameraMode);
        }
        if (value.getBool(Utils.keyBlurMode) != null) {
          isBlurSwitched = value.getBool(Utils.keyBlurMode);
        }
      });
    });
  }
}
