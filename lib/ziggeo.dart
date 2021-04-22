import 'package:flutter/services.dart';
import 'package:ziggeo/api/streams.dart';
import 'package:ziggeo/api/videos.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/player/player_config.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/uploading/uploading_config.dart';

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

  Ziggeo(String token) {
    setAppToken(token);
    startListeningChannels();
    _videosApi = VideosApi();
    _streamsApi = StreamsApi();
  }

  VideosApi _videosApi;
  StreamsApi _streamsApi;

  RecorderConfig _recorderConfig;
  QrScannerConfig _qrScannerConfig;
  UploadingConfig _uploadingConfig;
  FileSelectorConfig _fileSelectorConfig;
  PlayerConfig _playerConfig;

  VideosApi get videos => _videosApi;
  StreamsApi get streams => _streamsApi;

  PlayerConfig get playerConfig => _playerConfig;

  set playerConfig(PlayerConfig value) {
    _playerConfig = value;
    _ziggeoChannel.invokeMethod(
        'setPlayerConfig', _playerConfig.convertToMap());
  }

  FileSelectorConfig get fileSelectorConfig => _fileSelectorConfig;

  set fileSelectorConfig(FileSelectorConfig value) {
    _fileSelectorConfig = value;
    _ziggeoChannel.invokeMethod(
        'setFileSelectorConfig', _fileSelectorConfig.convertToMap());
  }

  QrScannerConfig get qrScannerConfig => _qrScannerConfig;

  set qrScannerConfig(QrScannerConfig value) {
    _qrScannerConfig = value;
    _ziggeoChannel.invokeMethod(
        'setQrScannerConfig', _qrScannerConfig.convertToMap());
  }

  UploadingConfig get uploadingConfig => _uploadingConfig;

  set uploadingConfig(UploadingConfig value) {
    _uploadingConfig = value;
    _ziggeoChannel.invokeMethod(
        'setUploadingConfig', _uploadingConfig.convertToMap());
  }

  RecorderConfig get recorderConfig => _recorderConfig;

  set recorderConfig(value) {
    _recorderConfig = value;
    _ziggeoChannel.invokeMethod(
        'setRecorderConfig', recorderConfig.convertToMap());
  }

  Future<String> get appToken async {
    return await _ziggeoChannel.invokeMethod('getAppToken');
  }

  Future<void> setAppToken(String token) async {
    return await _ziggeoChannel
        .invokeMethod('setAppToken', {'appToken': token});
  }

  Future<void> setClientAuthToken(String token) async {
    return await _ziggeoChannel
        .invokeMethod('setClientAuthToken', {'clientAuthToken': token});
  }

  Future<String> get clientAuthToken async {
    return await _ziggeoChannel.invokeMethod('getClientAuthToken');
  }

  Future<void> setServerAuthToken(String token) async {
    return await _ziggeoChannel
        .invokeMethod('setServerAuthToken', {'serverAuthToken': token});
  }

  Future<String> get serverAuthToken async {
    return await _ziggeoChannel.invokeMethod('getServerAuthToken');
  }

  Future<void> startCameraRecorder() async {
    return await _ziggeoChannel.invokeMethod('startCameraRecorder');
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

  Future<void> uploadFromFileSelector(Map<String, String> args) async {
    return await _ziggeoChannel
        .invokeMethod('uploadFromFileSelector', {"args": args});
  }

  Future<void> sendReport(List<String> logs) async {
    return await _ziggeoChannel.invokeMethod('sendReport', {"logs": logs});
  }

  void startListeningChannels() {
    listenToRecChannel();
    listenToFsChannel();
    listenToUplChannel();
    listenToPlChannel();
    listenToQrChannel();
  }

  void listenToRecChannel() {
    _recChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case 'streamingStarted':
          recorderConfig?.eventsListener?.onStreamingStarted();
          break;
        case 'loaded':
          recorderConfig?.eventsListener?.onLoaded();
          break;
        case 'accessGranted':
          recorderConfig?.eventsListener?.onAccessGranted();
          break;
        case 'noMicrophone':
          recorderConfig?.eventsListener?.onNoMicrophone();
          break;
        case 'accessForbidden':
          recorderConfig?.eventsListener?.onAccessForbidden(call.arguments);
          break;
        case 'hasMicrophone':
          recorderConfig?.eventsListener?.onHasMicrophone();
          break;
        case 'recordingStopped':
          recorderConfig?.eventsListener?.onRecordingStopped(call.arguments);
          break;
        case 'readyToRecord':
          recorderConfig?.eventsListener?.onReadyToRecord();
          break;
        case 'recordingStarted':
          recorderConfig?.eventsListener?.onRecordingStarted();
          break;
        case 'recordingProgress':
          recorderConfig?.eventsListener?.onRecordingProgress(call.arguments);
          break;
        case 'hasCamera':
          recorderConfig?.eventsListener?.onHasCamera();
          break;
        case 'microphoneHealth':
          recorderConfig?.eventsListener?.onMicrophoneHealth(call.arguments);
          break;
        case 'error':
          recorderConfig?.eventsListener
              ?.onError(new Exception(call.arguments));
          break;
        case 'canceledByUser':
          recorderConfig?.eventsListener?.onCanceledByUser();
          break;
        case 'streamingStopped':
          recorderConfig?.eventsListener?.onStreamingStopped();
          break;
        case 'manuallySubmitted':
          recorderConfig?.eventsListener?.onManuallySubmitted();
          break;
        case 'noCamera':
          recorderConfig?.eventsListener?.onNoCamera();
          break;
        case 'countdown':
          recorderConfig?.eventsListener?.onCountdown(call.arguments);
          break;
        case 'rerecord':
          recorderConfig?.eventsListener?.onRerecord();
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
          fileSelectorConfig?.eventsListener?.onLoaded();
          break;
        case 'accessGranted':
          fileSelectorConfig?.eventsListener?.onAccessGranted();
          break;
        case 'accessForbidden':
          fileSelectorConfig?.eventsListener?.onAccessForbidden(call.arguments);
          break;
        case 'error':
          fileSelectorConfig?.eventsListener?.onError(call.arguments);
          break;
        case 'canceledByUser':
          fileSelectorConfig?.eventsListener?.onCanceledByUser();
          break;
        case 'uploadSelected':
          fileSelectorConfig?.eventsListener?.onUploadSelected(call.arguments);
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
          _uploadingConfig?.eventsListener?.onProcessing(call.arguments);
          break;
        case 'uploadProgress':
          uploadingConfig?.eventsListener?.onUploadProgress(
            call.arguments["token"],
            call.arguments["path"],
            call.arguments["current"],
            call.arguments["total"],
          );
          break;
        case 'processed':
          _uploadingConfig?.eventsListener?.onProcessed(call.arguments);
          break;
        case 'verified':
          _uploadingConfig?.eventsListener?.onVerified(call.arguments);
          break;
        case 'uploadingStarted':
          _uploadingConfig?.eventsListener?.onUploadingStarted(call.arguments);
          break;
        case 'uploaded':
          uploadingConfig?.eventsListener
              ?.onUploaded(call.arguments["token"], call.arguments["path"]);
          break;
        case 'error':
          _uploadingConfig?.eventsListener?.onError(call.arguments);
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
          _playerConfig?.eventsListener?.onLoaded();
          break;
        case 'accessGranted':
          _playerConfig?.eventsListener?.onAccessGranted();
          break;
        case 'accessForbidden':
          _playerConfig?.eventsListener?.onAccessForbidden(call.arguments);
          break;
        case 'error':
          _playerConfig?.eventsListener?.onError(call.arguments);
          break;
        case 'canceledByUser':
          _playerConfig?.eventsListener?.onCanceledByUser();
          break;
        case 'paused':
          _playerConfig?.eventsListener?.onPaused();
          break;
        case 'ended':
          _playerConfig?.eventsListener?.onEnded();
          break;
        case 'seek':
          _playerConfig?.eventsListener?.onSeek(call.arguments);
          break;
        case 'readyToPlay':
          _playerConfig?.eventsListener?.onReadyToPlay();
          break;
        case 'playing':
          _playerConfig?.eventsListener?.onPlaying();
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
          qrScannerConfig?.eventsListener?.onLoaded();
          break;
        case 'accessGranted':
          qrScannerConfig?.eventsListener?.onAccessGranted();
          break;
        case 'accessForbidden':
          qrScannerConfig?.eventsListener?.onAccessForbidden(call.arguments);
          break;
        case 'error':
          qrScannerConfig?.eventsListener?.onError(call.arguments);
          break;
        case 'onDecoded':
          qrScannerConfig?.eventsListener?.onDecoded(call.arguments);
          break;
        case 'canceledByUser':
          qrScannerConfig?.eventsListener?.onCanceledByUser();
          break;
        case 'noCamera':
          qrScannerConfig?.eventsListener?.onNoCamera();
          break;
        case 'noMicrophone':
          qrScannerConfig?.eventsListener?.onNoMicrophone();
          break;
        case 'hasCamera':
          qrScannerConfig?.eventsListener?.onHasCamera();
          break;
        case 'hasMicrophone':
          qrScannerConfig?.eventsListener?.onHasMicrophone();
          break;
        default:
          print(
              "$_defaultChannelError Channel:$_plChannel, call:${call.method}");
      }
    });
  }
}
