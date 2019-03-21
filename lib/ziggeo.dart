import 'dart:async';

import 'package:flutter/services.dart';

class Ziggeo {
  static const MethodChannel _channel =
      const MethodChannel('ziggeo');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
