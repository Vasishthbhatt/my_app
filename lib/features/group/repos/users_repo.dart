import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/shared/global.dart';

class UserRepos {
  final String _user = FirebaseAuth.instance.currentUser!.uid.toString();

  bool isUpdating = false;

  Stream<List<UserModel>> getUser() {
    return userModelCollection
        .snapshots(includeMetadataChanges: false)
        .map((event) {
      return event.docs.where((element) => element.id != _user).map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return UserModel(
            uid: data['uid'],
            email: data['email'],
            name: data['name'],
            image: data['image'],
            lastActive: data['lastActive'].toDate(),
            isOnline: data['isOnline'],
            groupList: []);
      }).toList();
    });
  }

  // Future<void> addUserToGroup() async{
  //   await FirebaseFirestore.instance.collection(groupModelCollectionReferenceUid)
  // }
  // Stream<QuerySnapshot> get getUser {
  //   return userModelCollection.snapshots();
  // }

  Future<void> updateUser(bool isOnline) async {
    await userModelCollection.doc(_user).update({
      'isOnline': isOnline,
      'lastActive': Timestamp.fromDate(DateTime.now())
    });
  }

  // Future<UserModel> registerUser(String email,String name,String){

  // }
}
