import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

const appBarColor = Color.fromARGB(255, 224, 245, 255);
RegExp emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

const String loginPath = '/';
const String signUpPath = '/signup';
const String homePath = '/myhome';
const String loadingWidgetPath = '/loading';
const String chatPath = '/chat';
const String userPath = '/user';
const String dashBoardPath = '/dashboard';
const String notificationPath = '/notificationPath';

const String anonymousUserIconLink =
    'https://cdn-icons-png.flaticon.com/128/634/634795.png';

final CollectionReference userModelCollection =
    FirebaseFirestore.instance.collection('userModel');

const String groupModelCollectionReferenceUid = 'Groups';
