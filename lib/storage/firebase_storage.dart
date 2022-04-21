import 'dart:collection';
import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:roll_a_dice/models/leaderboard.dart';
import 'package:roll_a_dice/resources/constants.dart';
import 'package:roll_a_dice/services/authentication/user_profile.dart';

class FirebaseRealtimeStorage {
  final DatabaseReference _reference = FirebaseDatabase.instance.ref();
  late DatabaseReference _userRef;
  List<LeaderBoard> _leaderBoard = [];

  FirebaseRealtimeStorage() {
    _userRef = _reference.child('user');
  }

  void saveUserToDatabase(Map<String, dynamic> user) {
    _userRef.child(user['uid']!).once().then((value) {
      if (!value.snapshot.exists) {
        user['score'] = 0;
        user['attempt'] = 0;
        _userRef.child(user['uid']!).set(user);
      }
    });
  }

  void setUserValue(dynamic value, String key) {
    String uid = UserProfileProvider().userProfile!.uid;
    Map<String, int> _updatedValue = {key: value};
    _userRef.child(uid).update(_updatedValue);
  }

  Future<dynamic> getUserValue(String key) async {
    String uid = UserProfileProvider().userProfile!.uid;
    DatabaseEvent event = await _userRef.child(uid).child(key).once();
    print(event.snapshot.value);
    return event.snapshot.value;
  }

  Future<List<LeaderBoard>> getLeaderBoard() async {
    DatabaseEvent event = await _userRef.once();
    final jsonData = event.snapshot.value as Map<dynamic, dynamic>;
    for (var value in jsonData.values) {
      _leaderBoard.add(LeaderBoard(value['score'], value['photourl'] ?? 'photo',
          value['name'] ?? 'name'));
    }

    _leaderBoard.sort((a, b) => b.score.compareTo(a.score));
    return _leaderBoard;
  }
}
