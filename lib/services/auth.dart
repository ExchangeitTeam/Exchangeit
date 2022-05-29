import 'package:exchangeit/Objects/UserClass.dart';
import 'package:exchangeit/services/FirestoreServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Isfacebooklogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('facebooklogin', value);
  }

  Future FacebookSignIn() async {
    final fb = FacebookLogin();
    // Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    // Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // The user is suceessfully logged in
        final FacebookAccessToken accessToken = res.accessToken!;
        final AuthCredential authCredential =
            FacebookAuthProvider.credential(accessToken.token);
        final result =
            await FirebaseAuth.instance.signInWithCredential(authCredential);
        // Get profile data from facebook for use in the app
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');
        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        // fetch user email
        final email = await fb.getUserEmail();
        // But user can decline permission
        if (email != null) print('And your email is $email');

        final _user = _auth.currentUser;

        /*QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('users')
            .where("userId", isEqualTo: _user!.uid)
            .get();

        if (snapshot.docs.isEmpty) {
          facebookSignUp(profile);
        }

        facebooklogin();
         */
        Isfacebooklogin(true);
        break;
      case FacebookLoginStatus.cancel:
        Isfacebooklogin(false);
        break;
      case FacebookLoginStatus.error:
        // Login procedure failed
        Isfacebooklogin(false);
        break;
    }
  }

  Isgooglelogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('googlelogin', value);
  }

  Future FacebookLogout() async {
    await FacebookLogin().logOut();
    await FirebaseAuth.instance.signOut();
  }

  Future googleSignIn() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    if (googleUser == null) {
      Isgooglelogin(false);
    } else {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      Isgooglelogin(true);
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
  }

  Future googleLogout() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
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
