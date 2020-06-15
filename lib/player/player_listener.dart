import 'package:ziggeo/common/common_event_listener.dart';
import 'package:ziggeo/common/error_listener.dart';
import 'package:ziggeo/common/permission_listener.dart';

typedef OnPlaying = void Function();
typedef OnPaused = void Function();
typedef OnEnded = void Function();
typedef OnSeek = void Function(int);
typedef OnReadyToPlay = void Function();

class PlayerEventsListener
    implements CommonEventsListener, PermissionsEventsListener {
  OnPlaying onPlaying;
  OnPaused onPaused;
  OnEnded onEnded;
  OnSeek onSeek;
  OnReadyToPlay onReadyToPlay;

  @override
  OnAccessForbidden onAccessForbidden;

  @override
  OnAccessGranted onAccessGranted;

  @override
  OnCanceledByUser onCanceledByUser;

  @override
  OnError onError;

  @override
  OnLoaded onLoaded;

  PlayerEventsListener(
  {this.onPlaying,
      this.onPaused,
      this.onEnded,
      this.onSeek,
      this.onReadyToPlay,
      this.onAccessForbidden,
      this.onAccessGranted,
      this.onCanceledByUser,
      this.onError,
      this.onLoaded});
}
