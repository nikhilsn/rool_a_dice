import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  static String _ATTEMPTS = 'attempts';
  static String _SCORE = 'score';

  void setScore(int score) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(_SCORE, score);
  }

  void setAttempts(int attempts) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt(_ATTEMPTS, attempts);
  }

  Future<int> getScore() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_SCORE) ?? 0;
  }

  Future<int> getAttempts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(_ATTEMPTS) ?? 0;
  }

  void resetStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
