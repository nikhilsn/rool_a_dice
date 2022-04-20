import 'dart:async';

class AttemptStream {
  int _currentAttempts = 0;
  final StreamController<int> _attemptController = StreamController<int>();
  // final StreamController<int> _attemptEventController = StreamController<int>();

  Stream<int> get attempts => _attemptController.stream;

  // StreamSink<int> get attemptEventSink => _attemptEventController.sink;

  get increment => () {
    _currentAttempts++;
    _attemptController.sink.add(_currentAttempts);
  };

  int get currentAttempts=>_currentAttempts;
}
