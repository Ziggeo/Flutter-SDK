import 'package:ziggeo/common/error_listener.dart';

typedef OnUploadingStarted = void Function(String);
typedef OnUploadProgress = void Function(String, String, int, int);
typedef OnUploaded = void Function(String, String);
typedef OnVerified = void Function(String);
typedef OnProcessing = void Function(String);
typedef OnProcessed = void Function(String);

class UploadingEventsListener implements ErrorEventsListener {
  OnUploadingStarted? onUploadingStarted;
  OnUploadProgress? onUploadProgress;
  OnUploaded? onUploaded;
  OnVerified? onVerified;
  OnProcessing? onProcessing;
  OnProcessed? onProcessed;

  UploadingEventsListener(
      {this.onUploadingStarted,
      this.onUploadProgress,
      this.onUploaded,
      this.onVerified,
      this.onProcessing,
      this.onProcessed,
      this.onError});

  @override
  OnError? onError;
}
