import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback resumeCallback;
  final AsyncCallback suspendingCallback;

  LifecycleEventHandler({
    required this.resumeCallback,
    required this.suspendingCallback,
  });

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        if (resumeCallback != null) {
          await resumeCallback();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallback != null) {
          await suspendingCallback();
        }
        break;
    }
  }
}
