import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:my_app/features/chats/model/chat_message_model.dart';
import 'package:my_app/shared/global.dart';
import 'package:path/path.dart';

class ChatRepo {
  String _receiverId = "";
  String get receiverId => _receiverId;
  set receiverId(String value) {
    _receiverId = value;
  }



  List<Message> messages = [];
  Future<void> addMessage(Message message) async {
    await FirebaseFirestore.instance
        .collection('userModel')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(this.receiverId)
        .collection('messages')
        .add(message.toJson());
    await FirebaseFirestore.instance
        .collection('userModel')
        .doc(this.receiverId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .add(message.toJson());
    print(message.toJson());
  }

  Stream<List<Message>> getMessages() {
    return FirebaseFirestore.instance
        .collection('userModel')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(this.receiverId)
        .collection('messages')
        .orderBy('sentTime', descending: false)
        .snapshots(includeMetadataChanges: false)
        .map((event) {
      return event.docs.map((e) => Message.fromJson(e.data())).toList();
    });
  }

  // List<Message> getMessages() {
  //   FirebaseFirestore.instance
  //       .collection('userModel')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .collection('chats')
  //       .doc(this.receiverId)
  //       .collection('messages')
  //       .orderBy('sentTime', descending: false)
  //       .snapshots(includeMetadataChanges: true)
  //       .listen((messages) {
  //     this.messages =
  //         messages.docs.map((e) => Message.fromJson(e.data())).toList();
  //   });
  //   return messages;
  // }
}
