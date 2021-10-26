import 'package:ziggeo/common/common_event_listener.dart';
import 'package:ziggeo/common/error_listener.dart';
import 'package:ziggeo/common/permission_listener.dart';

typedef OnUploadSelected = void Function(List);

class FileSelectorEventsListener
    implements CommonEventsListener, PermissionsEventsListener {
  OnUploadSelected? onUploadSelected;

  @override
  OnAccessForbidden? onAccessForbidden;

  @override
  OnAccessGranted? onAccessGranted;

  @override
  OnCanceledByUser? onCanceledByUser;

  @override
  OnError? onError;

  @override
  OnLoaded? onLoaded;

  FileSelectorEventsListener(
      {this.onUploadSelected,
      this.onAccessForbidden,
      this.onAccessGranted,
      this.onCanceledByUser,
      this.onError,
      this.onLoaded});
}
