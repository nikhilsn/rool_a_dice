import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:roll_a_dice/storage/shared_preferences_storage.dart';

class LoginWithGoogle {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  signIn() async {
    final GoogleSignInAccount? googleAccount = await GoogleSignIn().signIn();
    if (googleAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleAccount.authentication;
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(googleCredential);
    }
  }

  void signOut() {
    _auth.signOut();
    SharedPreferencesStorage().resetStorage();
  }
}
