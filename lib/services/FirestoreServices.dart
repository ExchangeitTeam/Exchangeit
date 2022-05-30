import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<bool> IsUsernameTaken(String username) async {
    QuerySnapshot snap =
        await userCollection.where('username', isEqualTo: username).get();
    if (snap.docs.isNotEmpty) {
      return true;
    }
    return false;
  }

  static Future addUser(String uid, String? name) async {
    userCollection.doc(uid).set({
      'username': name,
      'searchKey': [],
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
    userCollection.doc(uid).set({
      'username': username,
      'searchKey': [],
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
      'follow_requests': '',
      'bookmarks': [],
      'deactivated': false,
      'old_username': '',
      'old_profile_pic': ''
    });
  }
}
