import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_app/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:fire_chat_app/app/modules/signUp/controllers/sign_up_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  CollectionReference usersDb = FirebaseFirestore.instance.collection('users');
  bool initialized = false;
  bool error = false;
  final user = SignInController().user;


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  handlePressed(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    if (room.id.isCurrency || room.users.isNotEmpty) {
      return room.name;
    }
    // Navigate to the Chat screen
    return null;
  }

  Future<void> addUser() {
    return usersDb
        .add({
          'full_name': SignUpController,
          'company': SignUpController,
        })
        .then((value) => print('"User Added'))
        .catchError((error) => print('failed to add user: $error'));
  }
}
