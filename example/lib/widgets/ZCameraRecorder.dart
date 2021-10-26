import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

typedef void ZCameraRecorderCreatedCallback(
    ZCameraRecorderController controller);

class ZCameraRecorder extends StatefulWidget {
  const ZCameraRecorder({
    Key key,
    this.onZCameraRecorderCreated,
  }) : super(key: key);

  final ZCameraRecorderCreatedCallback onZCameraRecorderCreated;

  @override
  State<StatefulWidget> createState() => _ZCameraRecorderState();
}

class _ZCameraRecorderState extends State<ZCameraRecorder> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'z_camera_view',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onZCameraRecorderCreated == null) {
      return;
    }
    widget.onZCameraRecorderCreated(new ZCameraRecorderController._(id));
  }
}

class ZCameraRecorderController {
  ZCameraRecorderController._(int id)
      : _channel = const MethodChannel('z_camera_recorder');

  final MethodChannel _channel;

  Future<bool> isRecording() async {
    return _channel.invokeMethod('isRecording');
  }

  Future<Function> getCallback() async {
    return _channel.invokeMethod('getCallback');
  }

  Future<String> getRecordedFile() async {
    return _channel.invokeMethod('getRecordedFile');
  }

  Future<void> start() async {
    return _channel.invokeMethod('start');
  }

  Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }

  Future<void> loadConfigs() async {
    return _channel.invokeMethod('loadConfigs');
  }

  Future<void> startRecording() async {
    return _channel.invokeMethod('startRecording');
  }

  Future<void> stopRecording() async {
    return _channel.invokeMethod('stopRecording');
  }

  Future<void> switchCamera() async {
    return _channel.invokeMethod('switchCamera');
  }
}
