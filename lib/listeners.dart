typedef OnLoadedListener = void Function();
typedef OnStreamingStarted = void Function();
typedef OnAccessGranted = void Function();
typedef OnNoMicrophone = void Function();
typedef OnAccessForbidden = void Function(List);
typedef OnHasMicrophone = void Function();
typedef OnRecordingStopped = void Function(String);
typedef OnProcessing = void Function(String);
typedef OnReadyToRecord = void Function();
typedef OnUploadProgress = void Function(String, String, int, int);
typedef OnProcessed = void Function(String);
typedef OnVerified = void Function(String);
typedef OnUploadSelected = void Function(List);
typedef OnRecordingStarted = void Function();
typedef OnRecordingProgress = void Function(int);
typedef OnPictureTaken = void Function(String);
typedef OnHasCamera = void Function();
typedef OnMicrophoneHealth = void Function(String);
typedef OnError = void Function(Exception);
typedef OnCanceledByUser = void Function();
typedef OnStreamingStopped = void Function();
typedef OnUploadingStarted = void Function(String);
typedef OnManuallySubmitted = void Function();
typedef OnUploaded = void Function(String, String);
typedef OnNoCamera = void Function();
typedef OnCountdown = void Function(int);

class RecorderEventsListener {
  OnLoadedListener onLoaded;
  OnStreamingStarted onStreamingStarted;
  OnAccessGranted onAccessGranted;
  OnNoMicrophone onNoMicrophone;
  OnAccessForbidden onAccessForbidden;
  OnHasMicrophone onHasMicrophone;
  OnRecordingStopped onRecordingStopped;
  OnProcessing onProcessing;
  OnReadyToRecord onReadyToRecord;
  OnUploadProgress onUploadProgress;
  OnProcessed onProcessed;
  OnVerified onVerified;
  OnUploadSelected onUploadSelected;
  OnRecordingStarted onRecordingStarted;
  OnRecordingProgress onRecordingProgress;
  OnPictureTaken onPictureTaken;
  OnHasCamera onHasCamera;
  OnMicrophoneHealth onMicrophoneHealth;
  OnError onError;
  OnCanceledByUser onCanceledByUser;
  OnStreamingStopped onStreamingStopped;
  OnUploadingStarted onUploadingStarted;
  OnManuallySubmitted onManuallySubmitted;
  OnUploaded onUploaded;
  OnNoCamera onNoCamera;
  OnCountdown onCountdown;

  RecorderEventsListener(
      {this.onLoaded,
      this.onStreamingStarted,
      this.onAccessGranted,
      this.onNoMicrophone,
      this.onAccessForbidden,
      this.onHasMicrophone,
      this.onRecordingStopped,
      this.onProcessing,
      this.onReadyToRecord,
      this.onUploadProgress,
      this.onProcessed,
      this.onVerified,
      this.onUploadSelected,
      this.onRecordingStarted,
      this.onRecordingProgress,
      this.onPictureTaken,
      this.onHasCamera,
      this.onMicrophoneHealth,
      this.onError,
      this.onCanceledByUser,
      this.onStreamingStopped,
      this.onUploadingStarted,
      this.onManuallySubmitted,
      this.onUploaded,
      this.onNoCamera,
      this.onCountdown});
}
