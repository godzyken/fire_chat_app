import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_chat_app/app/modules/createachatroom/controllers/createachatroom_controller.dart';
import 'package:fire_chat_app/app/modules/room/controllers/room_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/route_manager.dart';

class UsersController extends GetxController {
  //TODO: Implement UsersController
  // late final String? documentId;
  final usersList = FirebaseChatCore.instance.users();
  List<types.User?> users = [];

  CollectionReference? usersStore =
      FirebaseFirestore.instance.collection('users');

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
    final room = await RoomController().createRoom(otherUser, context);

    Get.toNamed('/chat',
        arguments: [room.id, room.type, room.users],
        preventDuplicates: true,
        parameters: usersStore!.parameters.entries.first.value);
  }

  handleSelect(types.User otherUser, String? name, BuildContext context) async {
    final room =
        await CreateachatroomController().createRoom(name, otherUser, context);

    Get.toNamed('/chat-room/$name',
        arguments: [room.id, name, room.type, room.users],
        preventDuplicates: true,
        parameters: usersStore!.parameters.entries.first.value);
  }
}
