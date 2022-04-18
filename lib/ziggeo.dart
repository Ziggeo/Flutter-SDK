import 'package:flutter/services.dart';
import 'package:ziggeo/api/audio.dart';
import 'package:ziggeo/api/streams.dart';
import 'package:ziggeo/api/videos.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/sensor_manager/sensor_manager_listener.dart';
import 'package:ziggeo/uploading/uploading_config.dart';

import 'api/images.dart';

class Ziggeo {
  static const _defaultChannelError =
      "Ignoring invoke from native. This normally shouldn\'t happen.";

  static const _ziggeoChannel = const MethodChannel('ziggeo');
  static const _recChannel = const MethodChannel('ziggeo_rec_callback');
  static const _fsChannel = const MethodChannel('ziggeo_fs_callback');
  static const _uplChannel = const MethodChannel('ziggeo_upl_callback');
  static const _plChannel = const MethodChannel('ziggeo_pl_callback');
  static const _qrChannel = const MethodChannel('ziggeo_qr_callback');
  static const _zvChannel = const MethodChannel('z_video_view');
  static const _smChannel = const MethodChannel('ziggeo_sensor_manager');

  Ziggeo(String? token) {
    setAppToken(token);
    startListeningChannels();
    _videosApi = VideosApi();
    _streamsApi = StreamsApi();
    _imagesApi = ImagesApi();
    _audiosApi = AudiosApi();
  }

  late VideosApi _videosApi;
  late StreamsApi _streamsApi;
  late ImagesApi _imagesApi;
  late AudiosApi _audiosApi;

  RecorderConfig? _recorderConfig;
  QrScannerConfig? _qrScannerConfig;
  UploadingConfig? _uploadingConfig;
  FileSelectorConfig? _fileSelectorConfig;
  PlayerConfig? _playerConfig;
  SensorManagerEventsListener? _smEventListener;

  VideosApi get videos => _videosApi;

  StreamsApi get streams => _streamsApi;

  AudiosApi get audios => _audiosApi;

  ImagesApi get images => _imagesApi;

  PlayerConfig? get playerConfig => _playerConfig;

  set playerConfig(PlayerConfig? value) {
    _playerConfig = value;
    _ziggeoChannel.invokeMethod(
        'setPlayerConfig', _playerConfig?.convertToMap());
  }

  FileSelectorConfig? get fileSelectorConfig => _fileSelectorConfig;

  set fileSelectorConfig(FileSelectorConfig? value) {
    _fileSelectorConfig = value;
    _ziggeoChannel.invokeMethod(
        'setFileSelectorConfig', _fileSelectorConfig?.convertToMap());
  }

  QrScannerConfig? get qrScannerConfig => _qrScannerConfig;

  set qrScannerConfig(QrScannerConfig? value) {
    _qrScannerConfig = value;
    _ziggeoChannel.invokeMethod(
        'setQrScannerConfig', _qrScannerConfig?.convertToMap());
  }

  UploadingConfig? get uploadingConfig => _uploadingConfig;

  set uploadingConfig(UploadingConfig? value) {
    _uploadingConfig = value;
    _ziggeoChannel.invokeMethod(
        'setUploadingConfig', _uploadingConfig?.convertToMap());
  }

  RecorderConfig? get recorderConfig => _recorderConfig;

  set recorderConfig(value) {
    _recorderConfig = value;
    _ziggeoChannel.invokeMethod(
        'setRecorderConfig', recorderConfig?.convertToMap());
    _ziggeoChannel.invokeMethod('setRecordingConfirmationDialogConfig',
        recorderConfig?.stopRecordingConfirmationDialogConfig?.convertToMap());
  }

  set setSensorManager(SensorManagerEventsListener? value) {
    _smEventListener = value;
  }

  Future<String?> get appToken async {
    return await _ziggeoChannel.invokeMethod('getAppToken');
  }

  Future<void> setAppToken(String? token) async {
    return await _ziggeoChannel
        .invokeMethod('setAppToken', {'appToken': token});
  }

  Future<void> setClientAuthToken(String? token) async {
    return await _ziggeoChannel
        .invokeMethod('setClientAuthToken', {'clientAuthToken': token});
  }

  Future<void> cancelUploadByPath(String path, bool deleteFile) async {
    return await _ziggeoChannel.invokeMethod(
        'cancelUploadByPath', {'path': path, 'deleteFile': deleteFile});
  }

  Future<void> cancelCurrentUpload(bool deleteFile) async {
    return await _ziggeoChannel
        .invokeMethod('cancelCurrentUpload', {'deleteFile': deleteFile});
  }

  Future<String?> get clientAuthToken async {
    return await _ziggeoChannel.invokeMethod('getClientAuthToken');
  }

  Future<void> setServerAuthToken(String? token) async {
    return await _ziggeoChannel
        .invokeMethod('setServerAuthToken', {'serverAuthToken': token});
  }

  Future<String?> get serverAuthToken async {
    return await _ziggeoChannel.invokeMethod('getServerAuthToken');
  }

  Future<void> startCameraRecorder() async {
    return await _ziggeoChannel.invokeMethod('startCameraRecorder');
  }

  Future<void> startAudioRecorder() async {
    return await _ziggeoChannel.invokeMethod('startAudioRecorder');
  }

  Future<void> startAudioPlayerByToken(String token) async {
    if (token != null) {
      return await _ziggeoChannel
          .invokeMethod('startAudioPlayerByToken', {"token": token});
    } else {
      return await _ziggeoChannel.invokeMethod('startAudioPlayerByToken');
    }
  }

  Future<void> startAudioPlayerByPath(Uri path) async {
    if (path != null) {
      return await _ziggeoChannel
          .invokeMethod('startAudioPlayerByPath', {"path": path});
    } else {
      return await _ziggeoChannel.invokeMethod('startAudioPlayerByPath');
    }
  }

  Future<void> showImageByToken(String token) async {
    return await _ziggeoChannel
        .invokeMethod('showImageByToken', {"token": token});
  }

  Future<void> showImageByPath(Uri path) async {
    return await _ziggeoChannel.invokeMethod('showImageByPath', {"path": path});
  }

  Future<void> startImageRecorder() async {
    return await _ziggeoChannel.invokeMethod('startImageRecorder');
  }

  Future<void> startPlayerFromToken(List<String> videoTokens) async {
    return await _ziggeoChannel
        .invokeMethod('startPlayer', {"tokens": videoTokens});
  }

  Future<void> startPlayerFromPath(List<String> videoPaths) async {
    return await _ziggeoChannel
        .invokeMethod('startPlayer', {"paths": videoPaths});
  }

  Future<void> startQrScanner() async {
    return await _ziggeoChannel.invokeMethod('startQrScanner');
  }

  Future<void> startScreenRecorder() async {
    return await _ziggeoChannel.invokeMethod('startScreenRecorder');
  }

  Future<void> uploadFromFileSelector(Map<String, String>? args) async {
    return await _ziggeoChannel
        .invokeMethod('uploadFromFileSelector', {"args": args});
  }

  Future<void> sendReport(List<String>? logs) async {
    return await _ziggeoChannel.invokeMethod('sendReport', {"logs": logs});
  }

  void startListeningChannels() {
    listenToRecChannel();
    listenToFsChannel();
    listenToUplChannel();
    listenToPlChannel();
    listenToQrChannel();
    listenToSensorManagerChannel();
  }

  void listenToRecChannel() {
    _recChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'streamingStarted':
          recorderConfig?.eventsListener?.onStreamingStarted?.call();
          break;
        case 'loaded':
          recorderConfig?.eventsListener?.onLoaded?.call();
          break;
        case 'accessGranted':
          recorderConfig?.eventsListener?.onAccessGranted?.call();
          break;
        case 'noMicrophone':
          recorderConfig?.eventsListener?.onNoMicrophone?.call();
          break;
        case 'accessForbidden':
          recorderConfig?.eventsListener?.onAccessForbidden
              ?.call(call.arguments);
          break;
        case 'hasMicrophone':
          recorderConfig?.eventsListener?.onHasMicrophone?.call();
          break;
        case 'recordingStopped':
          recorderConfig?.eventsListener?.onRecordingStopped
              ?.call(call.arguments);
          break;
        case 'readyToRecord':
          recorderConfig?.eventsListener?.onReadyToRecord?.call();
          break;
        case 'recordingStarted':
          recorderConfig?.eventsListener?.onRecordingStarted?.call();
          break;
        case 'recordingProgress':
          recorderConfig?.eventsListener?.onRecordingProgress
              ?.call(call.arguments);
          break;
        case 'hasCamera':
          recorderConfig?.eventsListener?.onHasCamera?.call();
          break;
        case 'microphoneHealth':
          recorderConfig?.eventsListener?.onMicrophoneHealth
              ?.call(call.arguments);
          break;
        case 'error':
          recorderConfig?.eventsListener?.onError
              ?.call(new Exception(call.arguments));
          break;
        case 'canceledByUser':
          recorderConfig?.eventsListener?.onCanceledByUser?.call();
          break;
        case 'streamingStopped':
          recorderConfig?.eventsListener?.onStreamingStopped?.call();
          break;
        case 'manuallySubmitted':
          recorderConfig?.eventsListener?.onManuallySubmitted?.call();
          break;
        case 'noCamera':
          recorderConfig?.eventsListener?.onNoCamera?.call();
          break;
        case 'countdown':
          recorderConfig?.eventsListener?.onCountdown?.call(call.arguments);
          break;
        case 'rerecord':
          recorderConfig?.eventsListener?.onRerecord?.call();
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }

  void listenToFsChannel() {
    _fsChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'loaded':
          fileSelectorConfig?.eventsListener?.onLoaded?.call();
          break;
        case 'accessGranted':
          fileSelectorConfig?.eventsListener?.onAccessGranted?.call();
          break;
        case 'accessForbidden':
          fileSelectorConfig?.eventsListener?.onAccessForbidden
              ?.call(call.arguments);
          break;
        case 'error':
          fileSelectorConfig?.eventsListener?.onError?.call(call.arguments);
          break;
        case 'canceledByUser':
          fileSelectorConfig?.eventsListener?.onCanceledByUser?.call();
          break;
        case 'uploadSelected':
          fileSelectorConfig?.eventsListener?.onUploadSelected
              ?.call(call.arguments);
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }

  void listenToUplChannel() {
    _uplChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'processing':
          _uploadingConfig?.eventsListener?.onProcessing?.call(call.arguments);
          break;
        case 'uploadProgress':
          uploadingConfig?.eventsListener?.onUploadProgress?.call(
            call.arguments["token"],
            call.arguments["path"],
            call.arguments["current"],
            call.arguments["total"],
          );
          break;
        case 'processed':
          _uploadingConfig?.eventsListener?.onProcessed?.call(call.arguments);
          break;
        case 'verified':
          _uploadingConfig?.eventsListener?.onVerified?.call(call.arguments);
          break;
        case 'uploadingStarted':
          _uploadingConfig?.eventsListener?.onUploadingStarted
              ?.call(call.arguments);
          break;
        case 'uploaded':
          uploadingConfig?.eventsListener?.onUploaded
              ?.call(call.arguments["token"], call.arguments["path"]);
          break;
        case 'error':
          _uploadingConfig?.eventsListener?.onError?.call(call.arguments);
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }

  void listenToPlChannel() {
    _plChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'loaded':
          _playerConfig?.eventsListener?.onLoaded?.call();
          break;
        case 'accessGranted':
          _playerConfig?.eventsListener?.onAccessGranted?.call();
          break;
        case 'accessForbidden':
          _playerConfig?.eventsListener?.onAccessForbidden
              ?.call(call.arguments);
          break;
        case 'error':
          _playerConfig?.eventsListener?.onError?.call(call.arguments);
          break;
        case 'canceledByUser':
          _playerConfig?.eventsListener?.onCanceledByUser?.call();
          break;
        case 'paused':
          _playerConfig?.eventsListener?.onPaused?.call();
          break;
        case 'ended':
          _playerConfig?.eventsListener?.onEnded?.call();
          break;
        case 'seek':
          _playerConfig?.eventsListener?.onSeek?.call(call.arguments);
          break;
        case 'readyToPlay':
          _playerConfig?.eventsListener?.onReadyToPlay?.call();
          break;
        case 'playing':
          _playerConfig?.eventsListener?.onPlaying?.call();
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }

  void listenToSensorManagerChannel() {
    _smChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'lightSensorLevel':
          _smEventListener?.lightSensorLevel?.call(call.arguments);
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }

  void listenToQrChannel() {
    _qrChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'loaded':
          qrScannerConfig?.eventsListener?.onLoaded?.call();
          break;
        case 'accessGranted':
          qrScannerConfig?.eventsListener?.onAccessGranted?.call();
          break;
        case 'accessForbidden':
          qrScannerConfig?.eventsListener?.onAccessForbidden
              ?.call(call.arguments);
          break;
        case 'error':
          qrScannerConfig?.eventsListener?.onError?.call(call.arguments);
          break;
        case 'onDecoded':
          qrScannerConfig?.eventsListener?.onDecoded?.call(call.arguments);
          break;
        case 'canceledByUser':
          qrScannerConfig?.eventsListener?.onCanceledByUser?.call();
          break;
        case 'noCamera':
          qrScannerConfig?.eventsListener?.onNoCamera?.call();
          break;
        case 'noMicrophone':
          qrScannerConfig?.eventsListener?.onNoMicrophone?.call();
          break;
        case 'hasCamera':
          qrScannerConfig?.eventsListener?.onHasCamera?.call();
          break;
        case 'hasMicrophone':
          qrScannerConfig?.eventsListener?.onHasMicrophone?.call();
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }
}
