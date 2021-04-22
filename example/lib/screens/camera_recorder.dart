import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/video_player.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/ZCameraRecorder.dart';

class CameraRecorderScreen extends StatefulWidget {
  static const String routeName = 'title_contact';
  final Ziggeo ziggeo;

  CameraRecorderScreen(this.ziggeo);

  @override
  _CameraRecorderScreenState createState() =>
      _CameraRecorderScreenState(ziggeo);
}

class _CameraRecorderScreenState extends State<CameraRecorderScreen> {
  final Ziggeo ziggeo;
  bool isCameraFront = false;
  bool isRecording = false;
  bool isPlayModeOn = false;

  File recordedFile;

  _CameraRecorderScreenState(this.ziggeo);

  ZCameraRecorderController controller;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => onBack(),
        child: Scaffold(
            body: Container(
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: ZCameraRecorder(
                          onZCameraRecorderCreated: _onZCameraRecorderCreated,
                        ),
                      )),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(common_margin),
                          child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Visibility(
                                    visible: isPlayModeOn,
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () => onPlayVideoClick(),
                                      icon: Icon(Icons.play_arrow),
                                      iconSize: btn_ic_size,
                                    )),
                                Visibility(
                                    visible: !isRecording,
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () => onMoveFrontCameraClick(),
                                      icon: isCameraFront
                                          ? Icon(Icons.camera_rear_rounded)
                                          : Icon(Icons.camera_front),
                                      iconSize: btn_ic_size,
                                    )),
                                Visibility(
                                    visible: !isRecording,
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () => onRecordClick(),
                                      icon: Icon(Icons.videocam),
                                      iconSize: btn_ic_size,
                                    )),
                                Visibility(
                                    visible: isRecording,
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () => onSaveClick(),
                                      icon: Icon(Icons.check),
                                      iconSize: btn_ic_size,
                                    ))
                              ]))
                    ],
                  ),
                  Stack(
                    alignment: Alignment.topLeft,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(common_margin),
                        child: IconButton(
                          onPressed: null,
                          icon: Icon(Icons.mic),
                          iconSize: btn_mic_size,
                        ),
                      )
                    ],
                  )
                ]))));
  }

  void _onZCameraRecorderCreated(ZCameraRecorderController controller) {
    this.controller = controller;
    controller.loadConfigs();
    controller.start();
  }

  onBack() {
    controller.stop();
    Navigator.of(context).pop();
  }

  onMoveFrontCameraClick() {
    setState(() {
      isCameraFront = !isCameraFront;
      controller.switchCamera();
    });
  }

  onPlayVideoClick() {
    controller.getRecordedFile().then((path) async {
      if (path != null) {
        await SharedPreferences.getInstance().then((value) {
          if (value.getBool(Utils.keyCustomPlayerMode) != null &&
              value.getBool(Utils.keyCustomPlayerMode)) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(ziggeo, null, path)));
          } else {
            ziggeo.startPlayerFromPath([path]);
          }
        });
      }
    });
  }

  onRecordClick() {
    if (!isRecording) {
      controller.startRecording();
    }

    setState(() {
      isRecording = !isRecording;
    });
  }

  onSaveClick() {
    controller.stopRecording();
    setState(() {
      isPlayModeOn = true;
      isRecording = false;
    });
  }
}
