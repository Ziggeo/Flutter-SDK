import 'package:ziggeo/common/error_listener.dart';

typedef OnNoMicrophone = void Function();
typedef OnHasMicrophone = void Function();
typedef OnHasCamera = void Function();
typedef OnNoCamera = void Function();
typedef OnMicrophoneHealth = void Function(String);

abstract class HardwareCheckEventsListener implements ErrorEventsListener {
  OnNoMicrophone onNoMicrophone;
  OnHasMicrophone onHasMicrophone;
  OnNoCamera onNoCamera;
  OnHasCamera onHasCamera;
  OnMicrophoneHealth onMicrophoneHealth;
}
