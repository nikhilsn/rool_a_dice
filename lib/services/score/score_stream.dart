import 'dart:async';

import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/storage/shared_preferences_storage.dart';

import '../../storage/firebase_storage.dart';

class ScoreStream {
  int _userScore = 0;
  final StreamController<int> _scoreController = StreamController<int>();
  final StreamController<int> _scoreEventController = StreamController<int>();

  Stream<int> get score => _scoreController.stream;

  StreamSink<int> get scoreEvent => _scoreEventController.sink;

  ScoreStream() {
    SharedPreferencesStorage().getScore().then((score) async {
      if (score == 0) {
        _userScore =
            await FirebaseRealtimeStorage().getUserValue(Constants.score);
        SharedPreferencesStorage().setScore(_userScore);
      } else {
        _userScore = score;
      }
      _scoreController.sink.add(_userScore);
    });

    _scoreEventController.stream.listen((score) {
      _userScore = _userScore + score;
      _scoreController.sink.add(_userScore);
      SharedPreferencesStorage().setScore(_userScore);
      FirebaseRealtimeStorage().setUserValue(_userScore, Constants.score);
    });
  }
}
