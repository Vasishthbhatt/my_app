import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class SignUpRepo {
  Future<void> registerUser(String email, String name, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
    }
  }
}
