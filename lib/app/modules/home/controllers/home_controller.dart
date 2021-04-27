import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:fire_chat_app/app/modules/room/controllers/room_controller.dart';
import 'package:fire_chat_app/app/modules/signUp/bindings/sign_up_binding.dart';
import 'package:fire_chat_app/app/modules/signUp/controllers/sign_up_controller.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final List<Map> myTimes =
      List.generate(10, (index) => {"id": index, "name": "Obi $index"})
          .toList();

  final items = List<ListItem>.generate(
    1200,
    (i) => i % 6 == 0
        ? HeadingItem("Heading $i")
        : MessageItem(
      "Sender $i", "Message body $i"
          ),
  );

  late final String? documentId = users.id;

  handlePressed(types.User otherUser, BuildContext context) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);

    if (room.id.isCurrency || room.users.isNotEmpty) {
      return room.name;
    }
    // Navigate to the Chat screen
    return null;
  }

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

  Future<void> addUser() {
    return users
        .add({
          'full_name': SignUpController,
          'company': SignUpController,
        })
        .then((value) => print('"User Added'))
        .catchError((error) => print('failed to add user: $error'));
  }
}

abstract class ListItem {}

class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}