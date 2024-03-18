import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/shared/global.dart';

class DashBoardRepo {
  Future<void> addUserToTheCurrentGroup(String groupId) async {
    await userModelCollection
        .doc(FirebaseAuth.instance.currentUser?.uid.toString())
        .update({
      'groupList': FieldValue.arrayUnion([groupId])
    });
  }
}
