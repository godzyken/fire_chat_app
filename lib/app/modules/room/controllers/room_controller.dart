import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  static final RoomController to = Get.find();
  final _db = FirebaseChatCore.instance;

  bool _isCreated = false;
  late types.Room room;

  createARoom(types.User otherUser, BuildContext context) async {
    _isCreated = false;
    try {

      room = await _db.createRoom(otherUser);
      _isCreated = true;
      return Get.toNamed('/chat-room/${room.id}/');
    } on FirebaseException catch (e, s) {
      print(s);
      _isCreated = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    _isCreated = _isCreated;
  }

  @override
  void onClose() {
  }

}
