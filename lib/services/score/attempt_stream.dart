import 'dart:async';

import 'package:roll_a_dice/storage/shared_preferences_storage.dart';

class AttemptStream {
  int _currentAttempts = 0;
  final StreamController<int> _attemptController = StreamController<int>();

  Stream<int> get attempts => _attemptController.stream;

  AttemptStream() {
    SharedPreferencesStorage().getAttempts().then((attempts) {
      print('attempts shared: $attempts');
      _currentAttempts = attempts;
      _attemptController.sink.add(_currentAttempts);
    });
  }

  get increment => () {
        _currentAttempts++;
        _attemptController.sink.add(_currentAttempts);
        SharedPreferencesStorage().setAttempts(_currentAttempts);
      };

  int get currentAttempts => _currentAttempts;
}
