import 'package:flutter/services.dart';
import 'package:ziggeo/file_selector/file_selector_config.dart';
import 'package:ziggeo/qr/qr_scanner_config.dart';
import 'package:ziggeo/recorder/recorder_config.dart';
import 'package:ziggeo/uploading/uploading_config.dart';

class Ziggeo {
  static const _ziggeoChannel = const MethodChannel('ziggeo');
  static const _recorderChannel = const MethodChannel('recorder');

  Ziggeo(String token) {
    setAppToken(token);
    startListening();
  }

  RecorderConfig _recorderConfig;
  QrScannerConfig _qrScannerConfig;
  UploadingConfig _uploadingConfig;
  FileSelectorConfig _fileSelectorConfig;

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

  Future<void> _methodCallHandler(MethodCall call) async {
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
      case 'uploadingStarted':
        uploadingConfig?.eventsListener?.onUploadingStarted(call.arguments);
        break;
      case 'uploadProgress':
        uploadingConfig?.eventsListener?.onUploadProgress(
          call.arguments["token"],
          call.arguments["path"],
          call.arguments["current"],
          call.arguments["total"],
        );
        break;
      case 'uploaded':
        uploadingConfig?.eventsListener
            ?.onUploaded(call.arguments["token"], call.arguments["path"]);
        break;
      case 'verified':
        uploadingConfig?.eventsListener?.onVerified(call.arguments);
        break;
      case 'processing':
        uploadingConfig?.eventsListener?.onProcessing(call.arguments);
        break;
      case 'processed':
        uploadingConfig?.eventsListener?.onProcessed(call.arguments);
        break;
      case 'uploadSelected':
        fileSelectorConfig?.eventsListener?.onUploadSelected(call.arguments);
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
        recorderConfig?.eventsListener?.onError(new Exception(call.arguments));
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
      case 'onQrDecoded':
        qrScannerConfig?.eventsListener?.onDecoded(call.arguments);
        break;
      default:
        print('Ignoring invoke from native. This normally shouldn\'t happen.');
    }
  }

  void startListening() {
    _recorderChannel.setMethodCallHandler(_methodCallHandler);
  }
}
