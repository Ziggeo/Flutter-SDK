import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ziggeo/configs.dart';

class Ziggeo {
  static const _ziggeoChannel = const MethodChannel('ziggeo');
  static const _recorderChannel = const MethodChannel('recorder');

  RecorderConfig _recorderConfig;

  Ziggeo(String token) {
    setAppToken(token);
    startListening();
  }

  set recorderConfig(value) {
    _recorderConfig = value;
    _ziggeoChannel.invokeMethod(
        'setRecorderConfig', recorderConfig.convertToMap());
  }

  RecorderConfig get recorderConfig => _recorderConfig;

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

  Future<void> startAudioRecorder() async {
    return await _ziggeoChannel.invokeMethod('startAudioRecorder');
  }

  Future<void> startPlayingFromToken(List<String> videoTokens) async {
    return await _ziggeoChannel
        .invokeMethod('startPlayer', {"tokens": videoTokens});
  }

  Future<void> startPlayingFromPath(List<String> videoPaths) async {
    return await _ziggeoChannel
        .invokeMethod('startPlayer', {"paths": videoPaths});
  }

  Future<void> startScreenRecorder() async {
    return await _ziggeoChannel.invokeMethod('startScreenRecorder');
  }

  Future<void> uploadFromFileSelector(Map<String, String> args) async {
    return await _ziggeoChannel
        .invokeMethod('uploadFromFileSelector', {"args": args});
  }

  Future<void> clearRecorded() async {
    return await _ziggeoChannel.invokeMethod('clearRecorded');
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
      case 'processing':
        recorderConfig?.eventsListener?.onProcessing(call.arguments);
        break;
      case 'readyToRecord':
        recorderConfig?.eventsListener?.onReadyToRecord();
        break;
      case 'uploadProgress':
        recorderConfig?.eventsListener?.onUploadProgress(
          call.arguments["token"],
          call.arguments["path"],
          call.arguments["current"],
          call.arguments["total"],
        );
        break;
      case 'processed':
        recorderConfig?.eventsListener?.onProcessed(call.arguments);
        break;
      case 'verified':
        recorderConfig?.eventsListener?.onVerified(call.arguments);
        break;
      case 'uploadSelected':
        recorderConfig?.eventsListener?.onUploadSelected(call.arguments);
        break;
      case 'recordingStarted':
        recorderConfig?.eventsListener?.onRecordingStarted();
        break;
      case 'recordingProgress':
        recorderConfig?.eventsListener?.onRecordingProgress(call.arguments);
        break;
      case 'onPictureTaken':
        recorderConfig?.eventsListener?.onPictureTaken(call.arguments);
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
      case 'uploadingStarted':
        recorderConfig?.eventsListener?.onUploadingStarted(call.arguments);
        break;
      case 'manuallySubmitted':
        recorderConfig?.eventsListener?.onManuallySubmitted();
        break;
      case 'uploaded':
        recorderConfig?.eventsListener
            ?.onUploaded(call.arguments["token"], call.arguments["path"]);
        break;
      case 'noCamera':
        recorderConfig?.eventsListener?.onNoCamera();
        break;
      case 'countdown':
        recorderConfig?.eventsListener?.onCountdown(call.arguments);
        break;
      default:
        print('Ignoring invoke from native. This normally shouldn\'t happen.');
    }
  }

  void startListening() {
    _recorderChannel.setMethodCallHandler(_methodCallHandler);
  }
}
