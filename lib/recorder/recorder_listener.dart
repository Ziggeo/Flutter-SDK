import 'package:ziggeo/common/common_event_listener.dart';
import 'package:ziggeo/common/error_listener.dart';
import 'package:ziggeo/common/hardware_listener.dart';
import 'package:ziggeo/common/permission_listener.dart';
import 'package:ziggeo/recorder/streaming_listener.dart';

typedef OnRecordingStopped = void Function(String);
typedef OnReadyToRecord = void Function();
typedef OnRecordingStarted = void Function();
typedef OnRecordingProgress = void Function(int);
typedef OnManuallySubmitted = void Function();
typedef OnCountdown = void Function(int);
typedef OnRerecord = void Function();

class RecorderEventsListener
    implements
        CommonEventsListener,
        PermissionsEventsListener,
        HardwareCheckEventsListener,
        StreamingEventsListener {
  OnReadyToRecord onReadyToRecord;
  OnRecordingStarted onRecordingStarted;
  OnRecordingProgress onRecordingProgress;
  OnRecordingStopped onRecordingStopped;
  OnManuallySubmitted onManuallySubmitted;
  OnCountdown onCountdown;
  OnRerecord onRerecord;

  @override
  OnAccessForbidden onAccessForbidden;

  @override
  OnAccessGranted onAccessGranted;

  @override
  OnCanceledByUser onCanceledByUser;

  @override
  OnError onError;

  @override
  OnHasCamera onHasCamera;

  @override
  OnHasMicrophone onHasMicrophone;

  @override
  OnLoaded onLoaded;

  @override
  OnMicrophoneHealth onMicrophoneHealth;

  @override
  OnNoCamera onNoCamera;

  @override
  OnNoMicrophone onNoMicrophone;

  @override
  OnStreamingStarted onStreamingStarted;

  @override
  OnStreamingStopped onStreamingStopped;

  RecorderEventsListener(
      {this.onReadyToRecord,
      this.onRecordingStarted,
      this.onRecordingProgress,
      this.onRecordingStopped,
      this.onManuallySubmitted,
      this.onCountdown,
      this.onAccessForbidden,
      this.onAccessGranted,
      this.onCanceledByUser,
      this.onError,
      this.onHasCamera,
      this.onHasMicrophone,
      this.onLoaded,
      this.onMicrophoneHealth,
      this.onNoCamera,
      this.onNoMicrophone,
      this.onStreamingStarted,
      this.onStreamingStopped});
}
