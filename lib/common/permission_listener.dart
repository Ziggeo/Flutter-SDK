import 'package:ziggeo/common/error_listener.dart';

typedef OnAccessGranted = void Function();
typedef OnAccessForbidden = void Function(List);

abstract class PermissionsEventsListener implements ErrorEventsListener {
  OnAccessGranted onAccessGranted;
  OnAccessForbidden onAccessForbidden;
}
