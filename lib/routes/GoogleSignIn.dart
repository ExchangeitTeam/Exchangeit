import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpWithGoogle extends ChangeNotifier {
  final signGoogle = GoogleSignIn();
  GoogleSignInAccount? _ouruser;
  GoogleSignInAccount get user => _ouruser!;
  Future LoginwithGoogle() async {
    final googleUser = await signGoogle.signIn();

    if (googleUser == null) return;
    _ouruser = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
  }
}
