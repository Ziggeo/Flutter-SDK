import 'package:flutter/material.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo/configs.dart';
import 'package:ziggeo/listeners.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Ziggeo _ziggeo;

  @override
  void initState() {
    super.initState();
    final String appToken = "YOUR_APP_TOKEN_HERE";
    _ziggeo = new Ziggeo(appToken);
    prepareRecorderConfig();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Ziggeo SDK demo app'),
          ),
          body: Center(
              child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text("Start camera recorder"),
                  onPressed: startCameraRecorder),
              RaisedButton(
                  child: Text("Start file selector"),
                  onPressed: startFileSelector)
            ],
          ))),
    );
  }

  void startCameraRecorder() {
    _ziggeo.startCameraRecorder();
  }

  void startFileSelector() {
    _ziggeo.uploadFromFileSelector(null);
  }

  void prepareRecorderConfig() {
    var recorderConfig = new RecorderConfig();

    var args = new Map<String, dynamic>();
    args["data"] = "{\"key\":\"value\"}";
    args["tags"] = new DateTime.now().millisecondsSinceEpoch;
    recorderConfig.extraArgs = args;

    recorderConfig.eventsListener = new RecorderEventsListener(
        onError: (exception) => print("onError:" + exception.toString()),
        onAccessForbidden: (permissions) =>
            print("onAccessForbidden:" + permissions.toString()),
        onCanceledByUser: () => print("onCanceledByUser"),
        onProcessed: (token) => print("onProcessed:" + token),
        onProcessing: (token) => print("onProcessing:" + token),
        onRecordingStarted: () => print("onRecordingStarted"),
        onRecordingStopped: (path) => print("onRecordingStopped:" + path),
        onUploaded: (token, path) =>
            print("onUploaded. Token:" + token + " Path:" + path),
        onUploadingStarted: (path) => print("onUploadingStarted:" + path),
        onUploadProgress: (token, path, current, total) => print(
            "onUploadProgress. Token:" +
                token +
                " " +
                current.toString() +
                "/" +
                total.toString() +
                " Path:" +
                path),
        onVerified: (token) => print("onVerified:" + token));

    _ziggeo.recorderConfig = recorderConfig;
  }
}
