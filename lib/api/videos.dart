import 'package:flutter/services.dart';

class VideosApi {
  static const _videosChannel = const MethodChannel('ziggeo_videos');

  VideosApi();

  Future<String> index(Map<String, String> args) async {
    return await _videosChannel.invokeMethod('index', {'args': args});
  }
}
