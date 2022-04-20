import 'dart:async';

class ScoreStream {
  int _userScore = 0;
  final StreamController<int> _scoreController = StreamController<int>();
  final StreamController<int> _scoreEventController = StreamController<int>();

  Stream<int> get score => _scoreController.stream;

  StreamSink<int> get scoreEvent => _scoreEventController.sink;

  ScoreStream() {
    _scoreEventController.stream.listen((score) {
      _userScore = _userScore + score;
      _scoreController.sink.add(_userScore);
    });
  }
}
