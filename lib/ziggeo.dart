import 'dart:async';

import 'package:flutter/services.dart';

class Ziggeo {
  static const MethodChannel _channel = const MethodChannel('ziggeo');

  Ziggeo(String token) {
    setAppToken(token);
  }

  Future<String> get appToken async {
    return await _channel.invokeMethod('getAppToken');
  }

  Future<void> setAppToken(String token) async {
    return await _channel.invokeMethod('setAppToken', {'appToken': token});
  }

  Future<void> setClientAuthToken(String token) async {
    return await _channel
        .invokeMethod('setClientAuthToken', {'clientAuthToken': token});
  }

  Future<String> get clientAuthToken async {
    return await _channel.invokeMethod('getClientAuthToken');
  }

  Future<String> get sessionKey async {
    return await _channel.invokeMethod('getSessionKey');
  }

  Future<void> setServerAuthToken(String token) async {
    return await _channel
        .invokeMethod('setServerAuthToken', {'serverAuthToken': token});
  }

  Future<String> get serverAuthToken async {
    return await _channel.invokeMethod('getServerAuthToken');
  }

  Future<void> startCameraRecorder() async {
    return await _channel.invokeMethod('startCameraRecorder');
  }

  Future<void> startAudioRecorder() async {
    return await _channel.invokeMethod('startAudioRecorder');
  }

  Future<void> startPlayingFromToken(List<String> videoTokens) async {
    return await _channel.invokeMethod('startPlayer', {"tokens": videoTokens});
  }

  Future<void> startPlayingFromPath(List<String> videoPaths) async {
    return await _channel.invokeMethod('startPlayer', {"paths": videoPaths});
  }

  Future<void> startScreenRecorder() async {
    return await _channel.invokeMethod('startScreenRecorder');
  }

  Future<void> uploadFromFileSelector(Map<String, String> args) async {
    return await _channel
        .invokeMethod('uploadFromFileSelector', {"args": args});
  }

  Future<void> clearRecorded() async {
    return await _channel.invokeMethod('clearRecorded');
  }

  Future<void> cancelRequest() async {
    return await _channel.invokeMethod('cancelRequest');
  }
}
