// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Groups> welcomeFromJson(String str) =>
    List<Groups>.from(json.decode(str).map((x) => Groups.fromJson(x)));

String welcomeToJson(List<Groups> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Groups {
  String groupId;
  String title;
  String body;
  // int maxEmployee;
  List<String> users;
  List<String> admins;

  Groups(
      {required this.groupId,
      required this.title,
      required this.body,
      required this.admins,
      required this.users});

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
      groupId: json["groupId"],
      title: json["title"],
      body: json["body"],
      admins: [],
      users: []);

  Map<String, dynamic> toJson() => {
        "groupId": groupId,
        "title": title,
        "body": body,
        "admin": admins,
        "users": users,
      };
}
