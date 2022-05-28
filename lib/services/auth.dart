import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exchangeit/Objects/UserClass.dart';
import 'package:exchangeit/services/FirestoreServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _curruser = FirebaseAuth.instance.currentUser;
  appUser? userFromLocal(User? user) {
    if (_curruser == null) {
      return null;
    }
    appUser tempUser = appUser(uid: _curruser!.uid);
    return tempUser;
  }

  Stream<appUser?> get getCurrentUser {
    return _auth.userChanges().map(userFromLocal);
  }

  User? _userFromFirebase(User? user) {
    return user;
  }

  Future googleSignIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User user = result.user!;
    var userDoc = await FirestoreService.userCollection.doc(user.uid).get();
    if (userDoc.exists) {
      return _userFromFirebase(user);
    }
    String name = user.displayName.toString().toLowerCase();
    name = name.replaceAll(' ', '');
    FirestoreService.addUser(user.uid, name);
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

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
}
