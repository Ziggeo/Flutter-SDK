import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/file_selector/file_selector_listener.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/player/player_listener.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/recorder/recorder_listener.dart';
import 'package:ziggeo/styles/player.dart';
import 'package:ziggeo/uploading/uploading_config.dart';
import 'package:ziggeo/uploading/uploading_listener.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/localization.dart';
import 'package:ziggeo_example/res/colors.dart';
import 'package:ziggeo_example/res/dimens.dart';
import 'package:ziggeo_example/screens/recording_details.dart';
import 'package:ziggeo_example/screens/recordings/recording_model.dart';
import 'package:ziggeo_example/utils/logger.dart';
import 'package:ziggeo_example/utils/utils.dart';
import 'package:ziggeo_example/widgets/TextLocalized.dart';

import '../camera_recorder.dart';

class RecordingsScreen extends StatefulWidget {
  static const String routeName = 'title_recordings';
  final Ziggeo ziggeo;

  RecordingsScreen(this.ziggeo);

  @override
  _RecordingsScreenState createState() => _RecordingsScreenState(ziggeo);
}

class _RecordingsScreenState extends State<RecordingsScreen> {
  List<RecordingModel>? recordings;
  late Ziggeo ziggeo;
  late ScrollController scrollController;
  bool dialVisible = true;
  bool isLoading = false;

  final AppLocalizations localize = AppLocalizations.instance;
  final List<LogModel> logBuffer = Logger.buffer;

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _RecordingsScreenState(this.ziggeo);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      refreshIndicatorKey.currentState?.show();
    });
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  void setDialVisible(bool value) {
    if (dialVisible != value) {
      setState(() {
        dialVisible = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshIndicatorKey,
        onRefresh: () => this.init(),
        child: this.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : recordings != null && recordings!.isNotEmpty
                ? ListView(
                    controller: scrollController,
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
        visible: dialVisible,
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

  onStartCameraRecorderPressed() async {
    await SharedPreferences.getInstance().then((value) {
      if (value.getBool(Utils.keyCustomCameraMode) != null &&
          (value.getBool(Utils.keyCustomCameraMode) ?? false)) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CameraRecorderScreen(ziggeo)));
      } else {
        ziggeo.startCameraRecorder();
      }
    });
  }

  onStartScreenRecorderPressed() {
    ziggeo.startScreenRecorder();
  }

  onStartAudioRecorderPressed() {
    ziggeo.startAudioRecorder();
  }

  onStartImageCapturePressed() {
    ziggeo.startImageRecorder();
  }

  onStartFileSelectorPressed() {
    ziggeo.uploadFromFileSelector(null);
  }

  init() async {
    var recordings = List<RecordingModel>.empty(growable: true);

    isLoading = true;
    setState(() {
      this.recordings = recordings;
    });

    if (ziggeo != null) {
      initCallbacks();
    }

    var recordingsVideo = List<RecordingModel>.empty(growable: true);
    var recordingsAudio = List<RecordingModel>.empty(growable: true);
    var recordingsImages = List<RecordingModel>.empty(growable: true);

    Future.wait([
      (() async => recordingsVideo = await ziggeo.videos.index(null).then(
              (value) => json
                  .decode(value!)
                  .cast<Map<String, dynamic>>()
                  .map<RecordingModel>((json) =>
                      RecordingModel.fromJson(json, RecordingModel.video_type))
                  .toList()))()
          .then((value) {}, onError: (error) => isLoading = false),
      (() async => recordingsAudio = await ziggeo.audios.index(null).then(
              (value) => json
                  .decode(value)
                  .cast<Map<String, dynamic>>()
                  .map<RecordingModel>((json) =>
                      RecordingModel.fromJson(json, RecordingModel.audio_type))
                  .toList()))()
          .then((value) {}, onError: (error) => isLoading = false),
      (() async => recordingsImages = await ziggeo.images.index(null).then(
              (value) => json
                  .decode(value)
                  .cast<Map<String, dynamic>>()
                  .map<RecordingModel>((json) =>
                      RecordingModel.fromJson(json, RecordingModel.image_type))
                  .toList()))()
          .then((value) {}, onError: (error) => isLoading = false)
    ]).then((value) {
      recordings.addAll(recordingsVideo);
      recordings.addAll(recordingsImages);
      recordings.addAll(recordingsAudio);
      recordings.sort((b, a) => a.created!.compareTo(b.created!));
      setState(() {
        this.isLoading = false;
        this.recordings = recordings;
      });
      isLoading = false;
    }, onError: (error) => isLoading = false);
  }

  getListChildren() {
    // isLoading = true;
    return List.generate(recordings!.length, (index) {
      return buildItemWidget(recordings![index]);
    });
  }

  Widget buildItemWidget(RecordingModel item) {
    final String token = item.token ?? '';
    final String tags = item.tags == null
        ? ''
        : item.tags.toString().replaceAll('[', '').replaceAll(']', '');
    final String state = item.state ?? '';
    final String dateCreated = DateFormat('dd.MM.yyyy hh:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(item.created! * 1000));

    final Icon icon = (item.type == RecordingModel.image_type)
        ? Icon(
            Icons.image,
            size: icon_size,
          )
        : (item.type == RecordingModel.audio_type)
            ? Icon(
                Icons.mic,
                size: icon_size,
              )
            : Icon(
                Icons.videocam,
                size: icon_size,
              );

    return InkWell(
        onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RecordingDetailsScreen(ziggeo, item)),
              ).then((value) {
                refreshIndicatorKey.currentState?.show();
                //todo need it?
                // isLoading = value;
              })
            },
        child: SizedBox(
            height: recording_item_height,
            child: Card(
                child: Padding(
              padding: EdgeInsets.all(common_margin),
              child: Row(
                children: <Widget>[
                  icon,
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
                              : Container(),
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

  initCallbacks() {
    initFileSelectorCallback();
    initPlayerCallback();
    initRecorderCallback();
    initUploaderCallback();
  }

  initFileSelectorCallback() {
    ziggeo.fileSelectorConfig = FileSelectorConfig();
    ziggeo.fileSelectorConfig?.eventsListener = FileSelectorEventsListener(
      onUploadSelected: (pathsList) =>
          addLogEvent('ev_fs_uploadSelected', details: pathsList.toString()),
      onLoaded: () => addLogEvent('ev_fs_loaded'),
      onCanceledByUser: () => addLogEvent('ev_fs_canceledByUser'),
      onAccessForbidden: (permissions) =>
          addLogEvent('ev_fs_accessForbidden', details: permissions.toString()),
      onAccessGranted: () => addLogEvent('ev_fs_accessGranted'),
      onError: (exception) =>
          addLogEvent('ev_fs_error', details: exception.toString()),
    );
  }

  initPlayerCallback() {
    ziggeo.playerConfig = PlayerConfig(playerStyle: PlayerStyle());
    ziggeo.playerConfig?.eventsListener = PlayerEventsListener(
      onLoaded: () => addLogEvent('ev_pl_loaded'),
      onCanceledByUser: () => addLogEvent('ev_pl_canceledByUser'),
      onAccessForbidden: (permissions) =>
          addLogEvent('ev_pl_accessForbidden', details: permissions.toString()),
      onAccessGranted: () => addLogEvent('ev_pl_accessGranted'),
      onError: (exception) =>
          addLogEvent('ev_pl_error', details: exception.toString()),
      onReadyToPlay: () => addLogEvent('ev_pl_readyToPlay'),
      onPlaying: () => addLogEvent('ev_pl_playing'),
      onSeek: (seekPos) =>
          addLogEvent('ev_pl_seek', details: seekPos.toString()),
      onPaused: () => addLogEvent('ev_pl_paused'),
      onEnded: () => addLogEvent('ev_pl_ended'),
    );
  }

  initRecorderCallback() {
    if (ziggeo.recorderConfig == null) ziggeo.recorderConfig = RecorderConfig();
    ziggeo.recorderConfig?.eventsListener = RecorderEventsListener(
      onError: (exception) =>
          addLogEvent('ev_rec_error', details: exception.toString()),
      onLoaded: () => addLogEvent('ev_rec_loaded'),
      onCanceledByUser: () => addLogEvent('ev_rec_canceledByUser'),
      onAccessForbidden: (permissions) => addLogEvent('ev_rec_accessForbidden',
          details: permissions.toString()),
      onAccessGranted: () => addLogEvent('ev_rec_accessGranted'),
      onCountdown: (time) =>
          addLogEvent('ev_rec_countdown', details: time.toString()),
      onHasCamera: () => addLogEvent('ev_rec_hasCamera'),
      onHasMicrophone: () => addLogEvent('ev_rec_hasMicrophone'),
      onNoCamera: () => addLogEvent('ev_rec_noCamera'),
      onNoMicrophone: () => addLogEvent('ev_rec_noMicrophone'),
      onManuallySubmitted: () => addLogEvent('ev_rec_manuallySubmitted'),
      onMicrophoneHealth: (health) =>
          addLogEvent('ev_rec_microphoneHealth', details: health),
      onReadyToRecord: () => addLogEvent('ev_rec_readyToRecord'),
      onRecordingProgress: (progress) =>
          addLogEvent('ev_rec_recordingProgress', details: progress.toString()),
      onRecordingStarted: () => addLogEvent('ev_rec_recordingStarted'),
      onRecordingStopped: (path) =>
          addLogEvent('ev_rec_recordingStopped', details: path),
      onStreamingStarted: () => addLogEvent('ev_rec_streamingStarted'),
      onStreamingStopped: () => addLogEvent('ev_rec_streamingStopped'),
    );
  }

  initUploaderCallback() {
    ziggeo.uploadingConfig = UploadingConfig();
    ziggeo.uploadingConfig?.eventsListener = UploadingEventsListener(
      onError: (exception) =>
          addLogEvent('ev_upl_error', details: exception.toString()),
      onUploadingStarted: (videoToken) =>
          addLogEvent('ev_upl_uploadingStarted', details: videoToken),
      onUploadProgress: (videoToken, path, current, total) => addLogEvent(
          'ev_upl_uploadProgress',
          details: "$current/$total t: $videoToken, p:$path"),
      onUploaded: (videoToken, path) =>
          addLogEvent('ev_upl_uploaded', details: "t:$videoToken, p:$path"),
      onVerified: (videoToken) =>
          addLogEvent('ev_upl_verified', details: videoToken),
      onProcessing: (videoToken) =>
          addLogEvent('ev_upl_processing', details: videoToken),
      onProcessed: (videoToken) =>
          addLogEvent('ev_upl_processed', details: videoToken),
    );
  }

  addLogEvent(String nameTag, {String? details}) {
    var model = LogModel(name: localize.text(nameTag), details: details);
    logBuffer.add(model);
  }
}
