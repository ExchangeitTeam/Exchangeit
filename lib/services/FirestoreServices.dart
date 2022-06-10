import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  static Future<bool> IsUsernameTaken(String username) async {
    QuerySnapshot snap =
        await userCollection.where('username', isEqualTo: username).get();
    if (snap.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  static Future addUser(String uid, String name) async {
    List<String> allpop = [];
    for (int i = 1; i <= name.length; i++) {
      allpop.add(name.substring(0, i).toLowerCase());
    }
    await userCollection.doc(uid).set({
      'username': name,
      'searchKey': allpop,
      'userId': uid,
      'isPrivate': 'public',
      'followers': [],
      'followerCount': 0,
      'following': [],
      'followingCount': 0,
      'university': '',
      "age": '',
      "bio": '',
      "profile_pic": '',
      'follow_requests': '',
      'bookmarks': [],
      'deactivated': false,
      'old_username': '',
      'old_profile_pic': ''
    });
  }

  static Future SignUpUseradd(
      String uid, String username, String uni, String age) async {
    List<String> allpos = [];
    for (int i = 1; i <= username.length; i++) {
      allpos.add(username.substring(0, i).toLowerCase());
    }
    await userCollection.doc(uid).set({
      'username': username,
      'searchKey': allpos,
      'userId': uid,
      'isPrivate': 'public',
      'followers': [],
      'followerCount': 0,
      'following': [],
      'followingCount': 0,
      'university': uni,
      "age": age,
      "bio": '',
      "profile_pic": '',
      'follow_requests': [],
      'bookmarks': [],
      'deactivated': false,
      'old_username': '',
      'old_profile_pic': ''
    });
  }

  static Future IsDeactivedlogin() async {
    final _user = FirebaseAuth.instance.currentUser;

    DocumentSnapshot logged_profile = await FirebaseFirestore.instance
        .collection('users')
        .doc(_user!.uid)
        .get();

    bool deactivated = logged_profile.get('deactivated');
    if (deactivated) {
      String image = logged_profile.get("old_profile_pic");
      String name = logged_profile.get("old_username");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .update({
        'username': name,
        'profile_pic': image,
        'deactivated': false,
      });

      List followers = logged_profile.get('followers');
      List following = logged_profile.get('following');

      for (int i = 0; i < followers.length; i++) {
        String followerId = followers[i];

        DocumentSnapshot follower = await FirebaseFirestore.instance
            .collection('users')
            .doc(followerId)
            .get();

        List followingArray = [];

        followingArray = follower.get('following');
        int followingCount = follower.get('followingCount');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(followerId)
            .update({
          'following': followingArray,
          'followingCount': followingCount,
        });
      }

      for (int i = 0; i < following.length; i++) {
        String followerId = following[i];

        DocumentSnapshot follower = await FirebaseFirestore.instance
            .collection('users')
            .doc(followerId)
            .get();

        List followerArray = [];

        followerArray = follower.get('followers');
        int followerCount = follower.get('followerCount');

        await FirebaseFirestore.instance
            .collection('users')
            .doc(followerId)
            .update({
          'followers': followerArray,
          'followerCount': followerCount,
        });
      }
    }
  }
}
