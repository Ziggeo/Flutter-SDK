import 'package:flutter/material.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/widgets/ZVideoPlayer.dart';

class VideoPlayerScreen extends StatefulWidget {
  static const String routeName = 'title_contact';
  final Ziggeo ziggeo;
  final String tokens;
  final String path;

  VideoPlayerScreen(this.ziggeo, this.tokens, this.path);

  @override
  _VideoPlayerScreenState createState() =>
      _VideoPlayerScreenState(ziggeo, tokens, path);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  final Ziggeo ziggeo;
  final String tokens;
  final String path;

  _VideoPlayerScreenState(this.ziggeo, this.tokens, this.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                child: Align(
      alignment: Alignment.center,
      child: ZVideoPlayer(
        onTVideoPlayerCreated: _onTVideoPlayerCreated,
      ),
    ))));
  }

  void _onTVideoPlayerCreated(VideoPlayerController controller) {
    controller.loadConfigs();
    controller.initViews();
    if (tokens != null) {
      controller.setVideoToken(tokens);
    }
    if (path != null) {
      controller.setVideoPath(path);
    }
    controller.prepareQueueAndStartPlaying();
  }
}
