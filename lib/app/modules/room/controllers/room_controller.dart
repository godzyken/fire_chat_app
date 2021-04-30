
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_app/app/modules/users/controllers/users_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  final _db = FirebaseChatCore.instance;
  final _auth = FirebaseAuth.instance;
  bool error = false;
  bool initialized = false;
  User? user;

  bool _isCreated = false;
  types.Room? room;
  int? counter = 10;

  final users = UsersController().users;

  Stream<List<types.Room>>? get streamRoom => _db.rooms();

  @override
  void onInit() {
    super.onInit();
    initializeFlutterFire();
  }

  @override
  void onReady() {
    super.onReady();
    _isCreated = _isCreated;
  }

  @override
  void onClose() {}

  initializeFlutterFire() async {
    try {
      _auth.authStateChanges().listen((User? userOn) {
        user = userOn;
      });
      initialized = true;
    } on FirebaseException catch (e, s) {
      print(s);
      error = true;
    }
  }

  logout() async {
    await _auth.signOut();
  }

  createRoom(types.User otherUser, BuildContext context) async {
    _isCreated = false;
    try {

      room = await _db.createRoom(otherUser);
      _isCreated = true;
      return Get.toNamed('/chat-room/${room!.id}/');
    } on FirebaseException catch (e, s) {
      print(s);
      _isCreated = false;
    }
  }

  createGroupRoom(users, String? name, String? imageUrl, BuildContext context) async {
    _isCreated = false;
    try {

      room = await _db.createGroupRoom(imageUrl: imageUrl!, name: name!, users: users);
      _isCreated = true;
      return Get.toNamed('/chat-room/${room!.id}/');
    } on FirebaseException catch (e, s) {
      print(s);
      _isCreated = false;
    }
  }

  updateMessage(types.Message message, BuildContext context) async {
    try {

      _db.updateMessage(message, room!.id);
      update();

      return Get.toNamed('/chat-room/${room!.id}/');
    } on FirebaseException catch (e, s) {
      print(s);
    }
  }

  countRoom() {
    try {
      var roomRef = FirebaseFirestore.instance.collection('rooms').doc().id;
      if(roomRef.isNotEmpty) {

        counter = roomRef.length;

        return counter;
      }
    } on Exception catch (e, s) {
      print(s);
    }
  }

}
