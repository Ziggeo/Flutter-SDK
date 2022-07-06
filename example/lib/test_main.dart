import 'package:flutter/material.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/recorder/stop_recording_confirmation_dialog_config.dart';
import 'package:ziggeo/styles/player.dart';
import 'package:ziggeo/uploading/uploading_config.dart';
import 'package:ziggeo/ziggeo.dart';
import 'package:ziggeo_example/res/dimens.dart';

final String appToken = 'appToken';
//player configs params
final bool isMuted = true;
final bool shouldShowSubtitles = true;
//file selector configs params
final int maxDuration = 8;
final bool shouldAllowMultipleSelection = true;
final int mediaType = FileSelectorConfig.audioMediaType;
//uploading configs params
final int syncInterval = 3000;
final bool shouldUseWifiOnly = true;
final bool shouldTurnOffUploader = true;
//qrScanner configs params
final bool shouldCloseAfterSuccessfulScan = false;
//recorder configs params
final bool shouldShowFaceOutline = true;
final bool isLiveStreaming = true;
final bool shouldAutoStartRecording = true;
final int startDelay = 2;
final bool blurMode = true;
final bool shouldSendImmediately = true;
final bool shouldDisableCameraSwitch = true;
final int videoQuality = 1;
final int facing = 1;
final int maxDurationRec = 100;
final bool shouldEnableCoverShot = true;
final bool shouldConfirmStopRecording = true;
final bool isPausedMode = false;
//recorder dialog config params
final titleText = "aa";
final mesText = "qq";
final posBtnText = "ss";
final negBtnText = "qwert";
//player style config params
final int controllerStyle = PlayerStyle.MODERN;
final int textColor = 123;
final int unplayedColor = 234;
final int playedColor = 567;
final int bufferedColor = 345;
final int tintColor = 246;
final int muteOffImageDrawable = 098;
final int muteOnImageDrawable = 056;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  late Ziggeo ziggeo;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ziggeo = Ziggeo(appToken);
    return MaterialApp(
      title: 'Ziggeo Tests',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(ziggeo: ziggeo),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.ziggeo}) : super(key: key);
  final Ziggeo ziggeo;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _appToken;
  bool? _isMuted;
  bool? _shouldShowSubtitles;

  int? _maxDuration;
  bool? _shouldAllowMultipleSelection;
  int? _mediaType;

  int? _syncInterval;
  bool? _shouldUseWifiOnly;
  bool? _shouldTurnOffUploader;

  bool? _shouldCloseAfterSuccessfulScan;

  bool? _shouldShowFaceOutline;
  bool? _isLiveStreaming;
  bool? _shouldAutoStartRecording;
  int? _startDelay;
  bool? _blurMode;
  bool? _shouldSendImmediately;
  bool? _shouldDisableCameraSwitch;
  int? _videoQuality;
  int? _facing;
  int? _maxDurationRec;
  bool? _shouldEnableCoverShot;
  bool? _shouldConfirmStopRecording;
  bool? _isPausedMode;

  String? _titleText;
  String? _mesText;
  String? _posBtnText;
  String? _negBtnText;

  int? _controllerStyle;
  int? _textColor;
  int? _unplayedColor;
  int? _playedColor;
  int? _bufferedColor;
  int? _tintColor;
  int? _muteOffImageDrawable;
  int? _muteOnImageDrawable;

  Future<void> _incrementCounter() async {
    //test App token setting
    var _appTokenTest = await widget.ziggeo.appToken ?? '';
    //test player config
    widget.ziggeo.playerConfig = PlayerConfig(
      isMuted: isMuted,
      shouldShowSubtitles: shouldShowSubtitles,
    );
    var _isMutedTest = (await widget.ziggeo.getPlayerConfig())?.isMuted;
    var _shouldShowSubtitlesTest =
        (await widget.ziggeo.getPlayerConfig())?.shouldShowSubtitles;

    //test file selector config
    widget.ziggeo.fileSelectorConfig = FileSelectorConfig(
      maxDuration: maxDuration,
      shouldAllowMultipleSelection: shouldAllowMultipleSelection,
      mediaType: mediaType,
    );
    var _shouldAllowMultipleSelectionTest =
        (await widget.ziggeo.getFileSelectorConfig())
            ?.shouldAllowMultipleSelection;
    var _maxDurationTest =
        (await widget.ziggeo.getFileSelectorConfig())?.maxDuration;
    var _mediaTypeTest =
        (await widget.ziggeo.getFileSelectorConfig())?.mediaType;

    //test uploading config
    widget.ziggeo.uploadingConfig = UploadingConfig(
      syncInterval: syncInterval,
      shouldUseWifiOnly: shouldUseWifiOnly,
      shouldTurnOffUploader: shouldTurnOffUploader,
    );
    var _syncIntervalTest =
        (await widget.ziggeo.getUploadingConfig())?.syncInterval;
    var _shouldUseWifiOnlyTest =
        (await widget.ziggeo.getUploadingConfig())?.shouldUseWifiOnly;
    var _shouldTurnOffUploaderTest =
        (await widget.ziggeo.getUploadingConfig())?.shouldTurnOffUploader;

    //test qrScanner config
    widget.ziggeo.qrScannerConfig = QrScannerConfig(
      shouldCloseAfterSuccessfulScan: shouldCloseAfterSuccessfulScan,
    );
    var _shouldCloseAfterSuccessfulScanTest =
        (await widget.ziggeo.getQrScannerConfig())
            ?.shouldCloseAfterSuccessfulScan;

    //test recorder config
    widget.ziggeo.recorderConfig = RecorderConfig(
        isLiveStreaming: isLiveStreaming,
        shouldShowFaceOutline: shouldShowFaceOutline,
        shouldAutoStartRecording: shouldAutoStartRecording,
        startDelay: startDelay,
        blurMode: blurMode,
        shouldSendImmediately: shouldSendImmediately,
        shouldDisableCameraSwitch: shouldDisableCameraSwitch,
        videoQuality: videoQuality,
        facing: facing,
        maxDuration: maxDurationRec,
        shouldEnableCoverShot: shouldEnableCoverShot,
        shouldConfirmStopRecording: shouldConfirmStopRecording,
        isPausedMode: isPausedMode,
        stopRecordingConfirmationDialogConfig:
            StopRecordingConfirmationDialogConfig(
          titleText: titleText,
          mesText: mesText,
          posBtnText: posBtnText,
          negBtnText: negBtnText,
        ));
    var _isLiveStreamingTest =
        (await widget.ziggeo.getRecorderConfig())?.isLiveStreaming;
    var _shouldShowFaceOutlineTest =
        (await widget.ziggeo.getRecorderConfig())?.shouldShowFaceOutline;
    var _shouldAutoStartRecordingTest =
        (await widget.ziggeo.getRecorderConfig())?.shouldAutoStartRecording;
    var _startDelayTest = (await widget.ziggeo.getRecorderConfig())?.startDelay;
    var _blurModeTest = (await widget.ziggeo.getRecorderConfig())?.blurMode;
    var _shouldSendImmediatelyTest =
        (await widget.ziggeo.getRecorderConfig())?.shouldSendImmediately;
    var _shouldDisableCameraSwitchTest =
        (await widget.ziggeo.getRecorderConfig())?.shouldDisableCameraSwitch;
    var _videoQualityTest =
        (await widget.ziggeo.getRecorderConfig())?.videoQuality;
    var _facingTest = (await widget.ziggeo.getRecorderConfig())?.facing;
    var _maxDurationRecTest =
        (await widget.ziggeo.getRecorderConfig())?.maxDuration;
    var _shouldEnableCoverShotTest =
        (await widget.ziggeo.getRecorderConfig())?.shouldEnableCoverShot;
    var _shouldConfirmStopRecordingTest =
        (await widget.ziggeo.getRecorderConfig())?.shouldConfirmStopRecording;
    var _isPausedModeTest = (await widget.ziggeo.getRecorderConfig())?.isPausedMode;

    // test uploading config
    widget.ziggeo.stopRecordingConfirmationDialogConfig =
        StopRecordingConfirmationDialogConfig(
      titleText: titleText,
      mesText: mesText,
      posBtnText: posBtnText,
      negBtnText: negBtnText,
    );
    var _titleTextTest =
        (await widget.ziggeo.getRecordingConfirmationDialogConfig())?.titleText;
    var _mesTextTest =
        (await widget.ziggeo.getRecordingConfirmationDialogConfig())?.mesText;
    var _posBtnTextTest =
        (await widget.ziggeo.getRecordingConfirmationDialogConfig())
            ?.posBtnText;
    var _negBtnTextTest =
        (await widget.ziggeo.getRecordingConfirmationDialogConfig())
            ?.negBtnText;

    //test player style
    widget.ziggeo.playerStyle = PlayerStyle(
      controllerStyle: controllerStyle,
      textColor: textColor,
      unplayedColor: unplayedColor,
      playedColor: playedColor,
      bufferedColor: bufferedColor,
      tintColor: tintColor,
      muteOffImageDrawable: muteOffImageDrawable,
      muteOnImageDrawable: muteOnImageDrawable,
    );
    var _controllerStyleTest =
        (await widget.ziggeo.getPlayerStyle())?.controllerStyle;
    var _textColorTest = (await widget.ziggeo.getPlayerStyle())?.textColor;
    var _unplayedColorTest =
        (await widget.ziggeo.getPlayerStyle())?.unplayedColor;
    var _playedColorTest = (await widget.ziggeo.getPlayerStyle())?.playedColor;
    var _bufferedColorTest =
        (await widget.ziggeo.getPlayerStyle())?.bufferedColor;
    var _tintColorTest = (await widget.ziggeo.getPlayerStyle())?.tintColor;
    var _muteOffImageDrawableTest =
        (await widget.ziggeo.getPlayerStyle())?.muteOffImageDrawable;
    var _muteOnImageDrawableTest =
        (await widget.ziggeo.getPlayerStyle())?.muteOnImageDrawable;

    setState(() {
      _appToken = _appTokenTest;
      _isMuted = _isMutedTest;
      _shouldShowSubtitles = _shouldShowSubtitlesTest;

      _maxDuration = _maxDurationTest;
      _shouldAllowMultipleSelection = _shouldAllowMultipleSelectionTest;
      _mediaType = _mediaTypeTest;

      _syncInterval = _syncIntervalTest;
      _shouldUseWifiOnly = _shouldUseWifiOnlyTest;
      _shouldTurnOffUploader = _shouldTurnOffUploaderTest;

      _shouldCloseAfterSuccessfulScan = _shouldCloseAfterSuccessfulScanTest;

      _shouldShowFaceOutline = _shouldShowFaceOutlineTest;
      _isLiveStreaming = _isLiveStreamingTest;
      _shouldAutoStartRecording = _shouldAutoStartRecordingTest;
      _startDelay = _startDelayTest;
      _blurMode = _blurModeTest;
      _shouldSendImmediately = _shouldSendImmediatelyTest;
      _shouldDisableCameraSwitch = _shouldDisableCameraSwitchTest;
      _videoQuality = _videoQualityTest;
      _facing = _facingTest;
      _maxDurationRec = _maxDurationRecTest;
      _shouldEnableCoverShot = _shouldEnableCoverShotTest;
      _shouldConfirmStopRecording = _shouldConfirmStopRecordingTest;
      _isPausedMode = _isPausedModeTest;

      _titleText = _titleTextTest;
      _mesText = _mesTextTest;
      _posBtnText = _posBtnTextTest;
      _negBtnText = _negBtnTextTest;

      _controllerStyle = _controllerStyleTest;
      _textColor = _textColorTest;
      _unplayedColor = _unplayedColorTest;
      _playedColor = _playedColorTest;
      _bufferedColor = _bufferedColorTest;
      _tintColor = _tintColorTest;
      _muteOffImageDrawable = _muteOffImageDrawableTest;
      _muteOnImageDrawable = _muteOnImageDrawableTest;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ziggeo Tests'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // shrinkWrap: true,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Ziggeo Configs Params:',
            ),
            buildItemWidget('App Token', _appToken ?? '_appToken is null'),
            const Text(
              'PlayerConfig:',
            ),
            buildItemWidget('isMuted: ', 'isMuted$_isMuted'),
            buildItemWidget('shouldShowSubtitles:',
                'shouldShowSubtitles$_shouldShowSubtitles'),
            const Text(
              'FileSelectorConfig:',
            ),
            buildItemWidget(
              'shouldAllowMultipleSelection: ',
              'shouldAllowMultipleSelection$_shouldAllowMultipleSelection',
            ),
            buildItemWidget('maxDuration:', 'maxDuration$_maxDuration'),
            buildItemWidget('mediaType:', 'mediaType$_mediaType'),
            const Text(
              'UploadingConfig:',
            ),
            buildItemWidget(
              'syncInterval: ',
              'syncInterval$_syncInterval',
            ),
            buildItemWidget(
                'shouldUseWifiOnly:', 'shouldUseWifiOnly$_shouldUseWifiOnly'),
            buildItemWidget('shouldTurnOffUploader: ',
                'shouldTurnOffUploader$_shouldTurnOffUploader'),
            const Text(
              'QrScannerConfig:',
            ),
            buildItemWidget(
              'shouldCloseAfterSuccessfulScan: ',
              'shouldCloseAfterSuccessfulScan$_shouldCloseAfterSuccessfulScan',
            ),
            const Text(
              'RecorderConfig:',
            ),
            buildItemWidget(
              'shouldShowFaceOutline: ',
              'shouldShowFaceOutline$_shouldShowFaceOutline',
            ),
            buildItemWidget(
                'isLiveStreaming: ', 'isLiveStreaming$_isLiveStreaming'),
            buildItemWidget('shouldAutoStartRecording: ',
                'shouldAutoStartRecording$_shouldAutoStartRecording'),
            buildItemWidget(
              'startDelay: ',
              'startDelay$_startDelay',
            ),
            buildItemWidget('blurMode: ', 'blurMode$_blurMode'),
            buildItemWidget('shouldSendImmediately: ',
                'shouldSendImmediately$_shouldSendImmediately'),
            buildItemWidget(
              'shouldDisableCameraSwitch: ',
              'shouldDisableCameraSwitch$_shouldDisableCameraSwitch',
            ),
            buildItemWidget('videoQuality:', 'videoQuality$_videoQuality'),
            buildItemWidget('facing:', 'facing$_facing'),
            buildItemWidget('maxDuration: ', 'maxDurationRec$_maxDurationRec'),
            buildItemWidget('shouldEnableCoverShot: ',
                'shouldEnableCoverShot$_shouldEnableCoverShot'),
            buildItemWidget('shouldConfirmStopRecording: ',
                'shouldConfirmStopRecording$_shouldConfirmStopRecording'),
            buildItemWidget('isPausedMode: ',
                'isPausedMode$_isPausedMode'),
            const Text(
              'RecorderDialogConfig:',
            ),
            buildItemWidget('titleText: ', 'titleText$_titleText'),
            buildItemWidget('mesText: ', 'mesText$_mesText'),
            buildItemWidget('posBtnText: ', 'posBtnText$_posBtnText'),
            buildItemWidget('negBtnText: ', 'negBtnText$_negBtnText'),
            const Text(
              'PlayerStyleConfig: ',
            ),
            buildItemWidget(
                'controllerStyle: ', 'controllerStyle$_controllerStyle'),
            buildItemWidget('textColor: ', 'textColor$_textColor'),
            buildItemWidget('unplayedColor: ', 'unplayedColor$_unplayedColor'),
            buildItemWidget('playedColor: ', 'playedColor$_playedColor'),
            buildItemWidget('bufferedColor: ', 'bufferedColor$_bufferedColor'),
            buildItemWidget('tintColor: ', 'tintColor$_tintColor'),
            buildItemWidget('muteOffImageDrawable: ',
                'muteOffImageDrawable$_muteOffImageDrawable'),
            buildItemWidget('muteOnImageDrawable: ',
                'muteOnImageDrawable$_muteOnImageDrawable'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildItemWidget(String itemName, String itemParam) {
    return InkWell(
      child: SizedBox(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(common_margin),
            child: Row(
              key: ValueKey(itemName),
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(common_half_margin),
                    child: Text(
                      itemName,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(common_half_margin),
                  child: Text(
                    itemParam,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
