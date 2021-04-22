import 'dart:io';

import 'package:flutter/services.dart';

class StreamsApi {
  static const _streamsChannel = const MethodChannel('ziggeo_streams');

  StreamsApi();

  Future<String> accept(String videoTokenOrKey, String streamTokenOrKey) async {
    return await _streamsChannel.invokeMethod('accept',
        {'videoToken': videoTokenOrKey, 'streamToken': streamTokenOrKey});
  }

  Future<String> destroy(String videoTokenOrKey, String streamTokenOrKey) async {
    return await _streamsChannel.invokeMethod('destroy',
        {'videoToken': videoTokenOrKey, 'streamToken': streamTokenOrKey});
  }

  Future<String> create(String videoTokenOrKey, File file, Map<String, String> args) async {
    return await _streamsChannel.invokeMethod('create',
        {'videoToken': videoTokenOrKey, 'path': file, 'args': args});
  }
}
