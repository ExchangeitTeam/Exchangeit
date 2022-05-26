import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<dynamic> signInWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        registerUserWithEmailPass(email, pass);
        return e.message ?? 'E-mail and/or Password not found';
      } else if (e.code == 'wrong-password') {
        return e.message ?? 'Password is not correct';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> registerUserWithEmailPass(String email, String pass) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      return uc.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return e.message ?? 'E-mail already in use';
      } else if (e.code == 'weak-password') {
        return e.message ?? 'Your password is weak';
      }
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
