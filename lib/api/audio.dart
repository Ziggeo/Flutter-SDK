import 'package:flutter/services.dart';

class AudiosApi {
  static const _imagesChannel = const MethodChannel('ziggeo_audios');

  AudiosApi();

  Future<String> index(Map<String, String>? args) async {
    return await _imagesChannel.invokeMethod('index', {'args': args});
  }

  Future<String> get(String videoTokenOrKey) async {
    return await _imagesChannel
        .invokeMethod('get', {'tokenOrKey': videoTokenOrKey});
  }

  Future<String> update(String json) async {
    return await _imagesChannel.invokeMethod('update', {'data': json});
  }

  Future<String> destroy(String videoTokenOrKey) async {
    return await _imagesChannel
        .invokeMethod('destroy', {'tokenOrKey': videoTokenOrKey});
  }

  Future<String> create(Map<String, String> args) async {
    return await _imagesChannel.invokeMethod('create', {'args': args});
  }
}
