import 'package:ziggeo/common/error_listener.dart';

typedef OnHasCamera = void Function();
typedef OnNoCamera = void Function();

abstract class CamHardwareCheckEventsListener implements ErrorEventsListener {
  OnNoCamera onNoCamera;
  OnHasCamera onHasCamera;
}
