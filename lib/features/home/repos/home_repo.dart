import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import 'package:my_app/features/home/models/home_model.dart';
import 'package:my_app/shared/global.dart';

class GroupsRepos {
  final CollectionReference<Map<String, dynamic>> postCollectionreference =
      FirebaseFirestore.instance.collection(groupModelCollectionReferenceUid);

  Stream<List<Groups>> getGroups() {
    return postCollectionreference
        .snapshots(includeMetadataChanges: true)
        .map((event) {
      return event.docs.map((e) => Groups.fromJson(e.data())).toList();
    });
  }

  Future<void> addGroup(Groups groups) async {
    postCollectionreference.add(groups.toJson());
  }
}
