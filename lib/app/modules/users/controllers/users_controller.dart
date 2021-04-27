
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/route_manager.dart';


class UsersController extends GetxController {
  //TODO: Implement UsersController
  // late final String? documentId;
  // final users = FirebaseChatCore.instance.users();

  CollectionReference users = FirebaseFirestore.instance.collection('users');


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

    Get.toNamed('/chat', arguments: [room.id, room.type, room.users], preventDuplicates: true, parameters: users.parameters.entries.first.value);
  }



}
