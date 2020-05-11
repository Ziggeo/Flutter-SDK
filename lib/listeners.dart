typedef OnAccessForbidden = void Function(List);
typedef OnRecordingStopped = void Function(String);
typedef OnProcessing = void Function(String);
typedef OnUploadProgress = void Function(String, String, int, int);
typedef OnProcessed = void Function(String);
typedef OnVerified = void Function(String);
typedef OnRecordingStarted = void Function();
typedef OnError = void Function(Exception);
typedef OnCanceledByUser = void Function();
typedef OnUploadingStarted = void Function(String);
typedef OnUploaded = void Function(String, String);

class RecorderEventsListener {
  OnAccessForbidden onAccessForbidden;
  OnRecordingStopped onRecordingStopped;
  OnProcessing onProcessing;
  OnUploadProgress onUploadProgress;
  OnProcessed onProcessed;
  OnVerified onVerified;
  OnRecordingStarted onRecordingStarted;
  OnError onError;
  OnCanceledByUser onCanceledByUser;
  OnUploadingStarted onUploadingStarted;
  OnUploaded onUploaded;

  RecorderEventsListener({
    this.onAccessForbidden,
    this.onRecordingStopped,
    this.onProcessing,
    this.onUploadProgress,
    this.onProcessed,
    this.onVerified,
    this.onRecordingStarted,
    this.onError,
    this.onCanceledByUser,
    this.onUploadingStarted,
    this.onUploaded,
  });
}
