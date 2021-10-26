import 'package:ziggeo/common/error_listener.dart';

typedef OnLoaded = void Function();
typedef OnCanceledByUser = void Function();

abstract class CommonEventsListener implements ErrorEventsListener {
  OnLoaded? onLoaded;
  OnCanceledByUser? onCanceledByUser;
}
