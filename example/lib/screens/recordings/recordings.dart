import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/recording_details.dart';
import 'package:ziggeo_example/screens/recordings/recording_model.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

class RecordingsScreen extends StatefulWidget {
  static const String routeName = '/recordings';

  @override
  _RecordingsScreenState createState() => _RecordingsScreenState();
}

class _RecordingsScreenState extends State<RecordingsScreen> {
  List<RecordingModel> recordings;
  Ziggeo ziggeo;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () => this.init(),
        child: recordings != null && recordings.length >= 0
            ? ListView(
                children: getListChildren(),
              )
            : Column(
                children: <Widget>[
                  SizedBox(
                    height: list_empty_message_margin_top,
                  ),
                  Center(
                      child: TextLocalized(
                    'message_recordings_list_empty',
                    textAlign: TextAlign.center,
                  ))
                ],
              ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(accent),
        animationSpeed: 50,
        children: [
          SpeedDialChild(
              backgroundColor: Color(accent),
              child: Icon(Icons.videocam, color: Colors.white),
              onTap: onStartCameraRecorderPressed),
          SpeedDialChild(
              backgroundColor: Color(accent),
              child: Icon(Icons.desktop_windows, color: Colors.white),
              onTap: onStartScreenRecorderPressed),
          SpeedDialChild(
              backgroundColor: Color(accent),
              child: Icon(Icons.mic, color: Colors.white),
              onTap: onStartAudioRecorderPressed),
          SpeedDialChild(
              backgroundColor: Color(accent),
              child: Icon(Icons.image, color: Colors.white),
              onTap: onStartImageCapturePressed),
          SpeedDialChild(
              backgroundColor: Color(accent),
              child: Icon(Icons.folder, color: Colors.white),
              onTap: onStartFileSelectorPressed),
        ],
      ),
    );
  }

  onStartCameraRecorderPressed() {
    ziggeo.startCameraRecorder();
  }

  onStartScreenRecorderPressed() {
    ziggeo.startScreenRecorder();
  }

  onStartAudioRecorderPressed() {
    Utils.showToast(context, AppLocalizations.instance.text('coming_soon'));
  }

  onStartImageCapturePressed() {
    Utils.showToast(context, AppLocalizations.instance.text('coming_soon'));
  }

  onStartFileSelectorPressed() {
    ziggeo.uploadFromFileSelector(null);
  }

  init() async {
    if (ziggeo == null) {
      final prefs = await SharedPreferences.getInstance();
      ziggeo = Ziggeo(prefs.getString(Utils.keyAppToken));
    }

    var recordings = await ziggeo.videos.index(null).then((value) => json
        .decode(value)
        .cast<Map<String, dynamic>>()
        .map<RecordingModel>((json) => RecordingModel.fromJson(json))
        .toList());

    setState(() {
      this.recordings = recordings;
    });
  }

  getListChildren() {
    return List.generate(recordings.length, (index) {
      return buildItemWidget(recordings[index]);
    });
  }

  Widget buildItemWidget(RecordingModel item) {
    final String token = item.token == null ? '' : item.token;
    final String tags = item.tags == null
        ? ''
        : item.tags.toString().replaceAll('[', '').replaceAll(']', '');
    final String state = item.state == null ? '' : item.state;
    final String dateCreated = DateFormat('dd.MM.yyyy hh:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(item.created * 1000));

    return InkWell(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordingDetailsScreen(ziggeo, item)),
              ).then((value) => refreshIndicatorKey.currentState?.show())
            },
        child: SizedBox(
            height: recording_item_height,
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(common_margin),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.videocam,
                    size: icon_size,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(common_half_margin),
                      child: Stack(
                        children: <Widget>[
                          Text(token, overflow: TextOverflow.ellipsis),
                          tags.isNotEmpty
                              ? Align(
                                  child: Text(tags),
                                  alignment: Alignment.bottomLeft,
                                )
                              : null
                        ].where((element) => element != null).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(common_half_margin),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            state,
                            style: TextStyle(color: getStateColor(state)),
                          ),
                        ),
                        Align(
                          child: Text(dateCreated),
                          alignment: Alignment.bottomCenter,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))));
  }

  Color getStateColor(String state) {
    switch (state) {
      case RecordingModel.status_failed:
        return Colors.red;
      case RecordingModel.status_ready:
        return Colors.green;
      case RecordingModel.status_processing:
        return Colors.yellow;
      default:
        return Color(secondaryText);
    }
  }
}
