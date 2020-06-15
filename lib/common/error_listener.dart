typedef OnError = void Function(Exception);

abstract class ErrorEventsListener {
  OnError onError;
}
