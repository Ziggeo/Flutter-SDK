import 'package:flutter/material.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class VideoEditorScreen extends StatefulWidget {
  static const String routeName = 'title_video_editor';

  @override
  _VideoEditorScreenState createState() => _VideoEditorScreenState();
}

class _VideoEditorScreenState extends State<VideoEditorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: TextLocalized('coming_soon'),
        alignment: Alignment.center,
      ),
    );
  }
}
