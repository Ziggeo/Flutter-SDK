import 'package:ziggeo/common/cam_hardware_listener.dart';
import 'package:ziggeo/common/common_event_listener.dart';
import 'package:ziggeo/common/error_listener.dart';
import 'package:ziggeo/common/mic_hardware_listener.dart';
import 'package:ziggeo/common/permission_listener.dart';

typedef OnDecoded = void Function(String);

class QrScannerEventListener
    implements
        CommonEventsListener,
        PermissionsEventsListener,
        CamHardwareCheckEventsListener,
        MicHardwareCheckEventsListener {
  OnDecoded onDecoded;

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

  QrScannerEventListener(
      {this.onDecoded,
      this.onAccessForbidden,
      this.onAccessGranted,
      this.onCanceledByUser,
      this.onError,
      this.onHasCamera,
      this.onHasMicrophone,
      this.onLoaded,
      this.onMicrophoneHealth,
      this.onNoCamera,
      this.onNoMicrophone});
}
