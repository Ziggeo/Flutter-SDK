import 'package:flutter/services.dart';

const _channel = const MethodChannel('recorder');

Future<void> _methodCallHandler(MethodCall call) async {
  print('_methodCallHandler '+'Method:'+call.method+'Args:'+call.arguments.toString());
  switch (call.method) {
    case 'streamingStarted':
      break;
    case 'loaded':
      break;
    case 'accessGranted':
      break;
    case 'noMicrophone':
      break;
    case 'accessForbidden':
      break;
    case 'hasMicrophone':
      break;
    case 'recordingStopped':
      break;
    case 'processing':
      break;
    case 'readyToRecord':
      break;
    case 'uploadProgress':
      break;
    case 'processed':
      break;
    case 'verified':
      break;
    case 'uploadSelected':
      break;
    case 'recordingStarted':
      break;
    case 'recordingProgress':
      break;
    case 'onPictureTaken':
      break;
    case 'hasCamera':
      break;
    case 'microphoneHealth':
      break;
    case 'error':
      break;
    case 'canceledByUser':
      break;
    case 'streamingStopped':
      break;
    case 'uploadingStarted':
      break;
    case 'manuallySubmitted':
      break;
    case 'uploaded':
      break;
    case 'noCamera':
      break;
    case 'countdown':
      break;
    default:
      print('Ignoring invoke from native. This normally shouldn\'t happen.');
  }
}

void startListening() {
  _channel.setMethodCallHandler(_methodCallHandler);
}
