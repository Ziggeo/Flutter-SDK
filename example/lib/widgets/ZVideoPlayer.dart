import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

typedef void ZVideoPlayerCreatedCallback(VideoPlayerController controller);

class ZVideoPlayer extends StatefulWidget {
  const ZVideoPlayer({
    Key key,
    this.onTVideoPlayerCreated,
  }) : super(key: key);

  final ZVideoPlayerCreatedCallback onTVideoPlayerCreated;

  @override
  State<StatefulWidget> createState() => _ZVideoPlayerState();
}

class _ZVideoPlayerState extends State<ZVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'z_video_player',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onTVideoPlayerCreated == null) {
      return;
    }
    widget.onTVideoPlayerCreated(new VideoPlayerController._(id));
  }
}

class VideoPlayerController {
  VideoPlayerController._(int id)
      : _channel = const MethodChannel('z_video_view');

  final MethodChannel _channel;

  Future<void> onResume() async {
    return _channel.invokeMethod('onResume');
  }

  Future<void> onPause() async {
    return _channel.invokeMethod('onPause');
  }

  Future<void> initViews() async {
    return _channel.invokeMethod('initViews');
  }

  Future<void> getCallback() async {
    return _channel.invokeMethod('getCallback');
  }

  Future<void> prepareQueueAndStartPlaying() async {
    return _channel.invokeMethod('prepareQueueAndStartPlaying');
  }

  Future<void> setVideoToken(String videoToken) async {
    return _channel.invokeMethod('setVideoToken', {"videoToken": videoToken});
  }

  Future<void> setVideoPath(String  videoPath) async {
    return _channel.invokeMethod('setVideoPath', {"videoPath": videoPath});
  }

  Future<void> loadConfigs() async {
    return _channel.invokeMethod('loadConfigs');
  }
}
