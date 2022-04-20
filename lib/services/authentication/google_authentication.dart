import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      print(userCredential.user!.displayName);
      print(userCredential.user!.uid);
      print(userCredential.user!.email);
      print(userCredential.user!.phoneNumber);
      print(userCredential.user!.photoURL);
    }
  }

  void signOut() => _auth.signOut();
}
