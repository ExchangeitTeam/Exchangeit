import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

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
}
