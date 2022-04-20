import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
class FirebaseUserStream {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final StreamController<bool> _userStream = StreamController<bool>();
  get userStream => _userStream.stream;

  void listen() {
    _AuthStateChangeListner();
  }

  void _AuthStateChangeListner() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        _userStream.sink.add(false);
      } else {
        _userStream.sink.add(true);
      }
    });
  }

  dispose(){
    _userStream.close();
  }
}
