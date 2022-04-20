import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:roll_a_dice/models/user.dart';

class UserProfileProvider {

  User? get userProfile => FirebaseAuth.instance.currentUser;
}
