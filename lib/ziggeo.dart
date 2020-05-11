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

  Future<void> startPlayerFromToken(List<String> videoTokens) async {
    return await _ziggeoChannel
        .invokeMethod('startPlayer', {"tokens": videoTokens});
  }

  Future<void> startPlayerFromPath(List<String> videoPaths) async {
    return await _ziggeoChannel
        .invokeMethod('startPlayer', {"paths": videoPaths});
  }

  Future<void> uploadFromFileSelector(Map<String, String> args) async {
    return await _ziggeoChannel
        .invokeMethod('uploadFromFileSelector', {"args": args});
  }

  Future<void> _methodCallHandler(MethodCall call) async {
    switch (call.method) {
      case 'accessForbidden':
        recorderConfig?.eventsListener?.onAccessForbidden(call.arguments);
        break;
      case 'recordingStopped':
        recorderConfig?.eventsListener?.onRecordingStopped(call.arguments);
        break;
      case 'processing':
        recorderConfig?.eventsListener?.onProcessing(call.arguments);
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
      case 'recordingStarted':
        recorderConfig?.eventsListener?.onRecordingStarted();
        break;
      case 'error':
        recorderConfig?.eventsListener?.onError(new Exception(call.arguments));
        break;
      case 'canceledByUser':
        recorderConfig?.eventsListener?.onCanceledByUser();
        break;
      case 'uploadingStarted':
        recorderConfig?.eventsListener?.onUploadingStarted(call.arguments);
        break;
      case 'uploaded':
        recorderConfig?.eventsListener
            ?.onUploaded(call.arguments["token"], call.arguments["path"]);
        break;
      default:
        print('Ignoring invoke from native.');
    }
  }

  void startListening() {
    _recorderChannel.setMethodCallHandler(_methodCallHandler);
  }
}
