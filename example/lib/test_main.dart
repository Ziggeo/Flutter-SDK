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
//recorder dialog config params
final Characters titleText = Characters("aa");
final Characters mesText = Characters("qq");
final Characters posBtnText = Characters("ss");
final Characters negBtnText = Characters("qwert");
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
  int _counter = 0;
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

  Characters? _titleText;
  Characters? _mesText;
  Characters? _posBtnText;
  Characters? _negBtnText;

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
    _appToken = await widget.ziggeo.appToken ?? '';
    //test player config
    widget.ziggeo.playerConfig = PlayerConfig(
      isMuted: isMuted,
      shouldShowSubtitles: shouldShowSubtitles,
    );
    _isMuted = (await widget.ziggeo.getPlayerConfig())?.isMuted;
    _shouldShowSubtitles =
        (await widget.ziggeo.getPlayerConfig())?.shouldShowSubtitles;

    //test file selector config
    widget.ziggeo.fileSelectorConfig = FileSelectorConfig(
      maxDuration: maxDuration,
      shouldAllowMultipleSelection: shouldAllowMultipleSelection,
      mediaType: mediaType,
    );
    _shouldAllowMultipleSelection =
        (await widget.ziggeo.getFileSelectorConfig())
            ?.shouldAllowMultipleSelection;
    _maxDuration = (await widget.ziggeo.getFileSelectorConfig())?.maxDuration;
    _mediaType = (await widget.ziggeo.getFileSelectorConfig())?.mediaType;

    //test uploading config
    widget.ziggeo.uploadingConfig = UploadingConfig(
      syncInterval: syncInterval,
      shouldUseWifiOnly: shouldUseWifiOnly,
      shouldTurnOffUploader: shouldTurnOffUploader,
    );
    _syncInterval = (await widget.ziggeo.getUploadingConfig())?.syncInterval;
    _shouldUseWifiOnly =
        (await widget.ziggeo.getUploadingConfig())?.shouldUseWifiOnly;
    _shouldTurnOffUploader =
        (await widget.ziggeo.getUploadingConfig())?.shouldTurnOffUploader;

    //test qrScanner config
    widget.ziggeo.qrScannerConfig = QrScannerConfig(
      shouldCloseAfterSuccessfulScan: shouldCloseAfterSuccessfulScan,
    );
    _shouldCloseAfterSuccessfulScan = (await widget.ziggeo.getQrScannerConfig())
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
        stopRecordingConfirmationDialogConfig:
            StopRecordingConfirmationDialogConfig(
          titleText: titleText,
          mesText: mesText,
          posBtnText: posBtnText,
          negBtnText: negBtnText,
        ));
    _isLiveStreaming =
        (await widget.ziggeo.getRecorderConfig())?.isLiveStreaming;
    _shouldShowFaceOutline =
        (await widget.ziggeo.getRecorderConfig())?.shouldShowFaceOutline;
    _shouldAutoStartRecording =
        (await widget.ziggeo.getRecorderConfig())?.shouldAutoStartRecording;
    _startDelay = (await widget.ziggeo.getRecorderConfig())?.startDelay;
    _blurMode = (await widget.ziggeo.getRecorderConfig())?.blurMode;
    _shouldSendImmediately =
        (await widget.ziggeo.getRecorderConfig())?.shouldSendImmediately;
    _shouldDisableCameraSwitch =
        (await widget.ziggeo.getRecorderConfig())?.shouldDisableCameraSwitch;
    _videoQuality = (await widget.ziggeo.getRecorderConfig())?.videoQuality;
    _facing = (await widget.ziggeo.getRecorderConfig())?.facing;
    _maxDurationRec = (await widget.ziggeo.getRecorderConfig())?.maxDuration;
    _shouldEnableCoverShot =
        (await widget.ziggeo.getRecorderConfig())?.shouldEnableCoverShot;
    _shouldConfirmStopRecording =
        (await widget.ziggeo.getRecorderConfig())?.shouldConfirmStopRecording;

    //test uploading config
    // widget.ziggeo.stopRecordingConfirmationDialogConfig =
    //     StopRecordingConfirmationDialogConfig(
    //   titleText: titleText,
    //   mesText: mesText,
    //   posBtnText: posBtnText,
    //   negBtnText: negBtnText,
    // );
    _titleText =
        (await widget.ziggeo.getRecordingConfirmationDialogConfig())?.titleText;
    _mesText =
        (await widget.ziggeo.getRecordingConfirmationDialogConfig())?.mesText;
    _posBtnText = (await widget.ziggeo.getRecordingConfirmationDialogConfig())
        ?.posBtnText;
    _negBtnText = (await widget.ziggeo.getRecordingConfirmationDialogConfig())
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
    _controllerStyle = (await widget.ziggeo.getPlayerStyle())?.controllerStyle;
    _textColor = (await widget.ziggeo.getPlayerStyle())?.textColor;
    _unplayedColor = (await widget.ziggeo.getPlayerStyle())?.unplayedColor;
    _playedColor = (await widget.ziggeo.getPlayerStyle())?.playedColor;
    _bufferedColor = (await widget.ziggeo.getPlayerStyle())?.bufferedColor;
    _tintColor = (await widget.ziggeo.getPlayerStyle())?.tintColor;
    _muteOffImageDrawable =
        (await widget.ziggeo.getPlayerStyle())?.muteOffImageDrawable;
    _muteOnImageDrawable =
        (await widget.ziggeo.getPlayerStyle())?.muteOnImageDrawable;

    setState(() {
      _counter++;
      _appToken = _appToken;
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
            buildItemWidget('shouldTurnOffUploader:',
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
                'isLiveStreaming:', 'isLiveStreaming$_isLiveStreaming'),
            buildItemWidget('shouldAutoStartRecording:',
                'shouldAutoStartRecording$_shouldAutoStartRecording'),
            buildItemWidget(
              'startDelay: ',
              'startDelay$_startDelay',
            ),
            buildItemWidget('blurMode:', 'blurMode$_blurMode'),
            buildItemWidget('shouldSendImmediately:',
                'shouldSendImmediately$_shouldSendImmediately'),
            buildItemWidget(
              'shouldDisableCameraSwitch: ',
              'shouldDisableCameraSwitch$_shouldDisableCameraSwitch',
            ),
            buildItemWidget('videoQuality:', 'videoQuality$_videoQuality'),
            buildItemWidget('facing:', 'facing$_facing'),
            buildItemWidget('maxDuration:', 'maxDurationRec$_maxDurationRec'),
            buildItemWidget('shouldEnableCoverShot:',
                'shouldEnableCoverShot$_shouldEnableCoverShot'),
            buildItemWidget('shouldConfirmStopRecording:',
                'shouldConfirmStopRecording$_shouldConfirmStopRecording'),
            const Text(
              'RecorderDialogConfig:',
            ),
            buildItemWidget('titleText: ', 'titleText$_titleText'),
            buildItemWidget('mesText:', 'mesText$_mesText'),
            buildItemWidget('posBtnText:', 'posBtnText$_posBtnText'),
            buildItemWidget('negBtnText: ', 'negBtnText$_negBtnText'),
            const Text(
              'PlayerStyleConfig:',
            ),
            buildItemWidget(
                'controllerStyle: ', 'controllerStyle$_controllerStyle'),
            buildItemWidget('textColor:', 'textColor$_textColor'),
            buildItemWidget('unplayedColor:', 'unplayedColor$_unplayedColor'),
            buildItemWidget('playedColor: ', 'playedColor$_playedColor'),
            buildItemWidget('bufferedColor: ', 'bufferedColor$_bufferedColor'),
            buildItemWidget('tintColor:', 'tintColor$_tintColor'),
            buildItemWidget('muteOffImageDrawable:',
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
