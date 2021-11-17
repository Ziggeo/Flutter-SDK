import 'package:ziggeo/common/error_listener.dart';

typedef OnStreamingStarted = void Function();
typedef OnStreamingStopped = void Function();

abstract class StreamingEventsListener implements ErrorEventsListener {
  OnStreamingStarted? onStreamingStarted;
  OnStreamingStopped? onStreamingStopped;
}
