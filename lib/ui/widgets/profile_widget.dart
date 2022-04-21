import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/authentication/google_authentication.dart';
import '../../services/authentication/user_profile.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  Widget _profileSection(BuildContext context) {
    User? user = UserProfileProvider().userProfile;
    if (user == null) {
      LoginWithGoogle().signOut();
    }

    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(9),
                bottomRight: Radius.circular(9)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue,
                offset: Offset(0, 9),
              ),
            ],
            color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: user!.photoURL == null
                ? const Icon(Icons.person)
                : CircleAvatar(
                    foregroundImage: Image.network(user.photoURL!).image,
                  ),
            title: Text(user.displayName!),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _profileSection(context);
  }
}
