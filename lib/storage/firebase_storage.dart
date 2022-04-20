import 'package:firebase_database/firebase_database.dart';
import 'package:roll_a_dice/services/authentication/user_profile.dart';

class FirebaseRealtimeStorage {
  final DatabaseReference _reference = FirebaseDatabase.instance.ref();
  late DatabaseReference _userRef;

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
}
