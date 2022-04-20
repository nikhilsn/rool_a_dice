import 'dart:async';

import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/storage/firebase_storage.dart';
import 'package:roll_a_dice/storage/shared_preferences_storage.dart';

class AttemptStream {
  int _currentAttempts = 0;
  final StreamController<int> _attemptController = StreamController<int>();

  Stream<int> get attempts => _attemptController.stream;

  AttemptStream() {
    SharedPreferencesStorage().getAttempts().then((attempts) async {
      if (attempts == 0) {
        _currentAttempts =
            await FirebaseRealtimeStorage().getUserValue(Constants.attempt);
        SharedPreferencesStorage().setAttempts(_currentAttempts);
      } else {
        _currentAttempts = attempts;
      }
      _attemptController.sink.add(_currentAttempts);
    });
  }

  get increment => () {
        _currentAttempts++;
        _attemptController.sink.add(_currentAttempts);
        SharedPreferencesStorage().setAttempts(_currentAttempts);
        FirebaseRealtimeStorage().setUserValue(_currentAttempts, Constants.attempt);
      };

  int get currentAttempts => _currentAttempts;
}
