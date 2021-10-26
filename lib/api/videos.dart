import 'dart:io';

import 'package:flutter/services.dart';

class VideosApi {
  static const _videosChannel = const MethodChannel('ziggeo_videos');

  VideosApi();

  Future<String?> index(Map<String, String>? args) async {
    return await _videosChannel.invokeMethod('index', {'args': args});
  }

  Future<String?> get(String videoTokenOrKey) async {
    return await _videosChannel
        .invokeMethod('get', {'videoToken': videoTokenOrKey});
  }

  Future<String?> getVideoUrl(String videoTokenOrKey) async {
    return await _videosChannel
        .invokeMethod('getVideoUrl', {'videoToken': videoTokenOrKey});
  }

  Future<String?> getImageUrl(String videoTokenOrKey) async {
    return await _videosChannel
        .invokeMethod('getImageUrl', {'videoToken': videoTokenOrKey});
  }

  Future<String?> update(String json) async {
    return await _videosChannel.invokeMethod('update', {'data': json});
  }

  Future<String?> destroy(String videoTokenOrKey) async {
    return await _videosChannel
        .invokeMethod('destroy', {'videoToken': videoTokenOrKey});
  }

  Future<String?> create(Map<String, String>? args) async {
    return await _videosChannel.invokeMethod('create', {'args': args});
  }
}
