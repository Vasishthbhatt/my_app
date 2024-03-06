import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/features/group/model/user_model.dart';
import 'package:my_app/shared/global.dart';

class SignUpRepo {
  Future<void> registerUser(String email, String name, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await createUser(UserModel(
          uid: FirebaseAuth.instance.currentUser!.uid.toString(),
          email: email,
          name: name,
          lastActive: DateTime.now(),
          isOnline: true));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> createUser(UserModel userModel) async {
    await userModelCollection.doc(userModel.uid).set({
      'uid': userModel.uid,
      'email': userModel.email,
      'image': userModel.image,
      'isOnline': userModel.isOnline,
      'lastActive': userModel.lastActive,
      'name': userModel.name
    });
  }
}
