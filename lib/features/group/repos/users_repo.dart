import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/features/group/model/user_model.dart';

class UserRepos {
  final CollectionReference _userModelCollection =
      FirebaseFirestore.instance.collection('userModel');

  final String _user = FirebaseAuth.instance.currentUser!.uid.toString();

  bool isUpdating = false;

  Stream<List<UserModel>> getUser() {
    return _userModelCollection.snapshots().map((event) {
      return event.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return UserModel(
            uid: data['uid'],
            email: data['email'],
            name: data['name'],
            image: data['image'],
            lastActive: data['lastActive'].toDate(),
            isOnline: data['isOnline']);
      }).toList();
    });
  }

  Future<void> updateUser(bool isOnline) async {
    await _userModelCollection.doc().update({
      'isOnline': isOnline,
      'lastActive': Timestamp.fromDate(DateTime.now())
    });
  }

  // Future<UserModel> registerUser(String email,String name,String){

  // }

  Future<void> createUser(UserModel userModel) async {
    await _userModelCollection.doc().set({
      'uid': userModel.uid,
      'email': userModel.email,
      'image': userModel.image,
      'isOnline': userModel.isOnline,
      'lastActive': userModel.lastActive,
      'name': userModel.name
    });
  }
}
