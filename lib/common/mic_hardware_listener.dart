import 'package:ziggeo/common/error_listener.dart';

typedef OnNoMicrophone = void Function();
typedef OnHasMicrophone = void Function();
typedef OnMicrophoneHealth = void Function(String);

abstract class MicHardwareCheckEventsListener implements ErrorEventsListener {
  OnNoMicrophone onNoMicrophone;
  OnHasMicrophone onHasMicrophone;
  OnMicrophoneHealth onMicrophoneHealth;
}
