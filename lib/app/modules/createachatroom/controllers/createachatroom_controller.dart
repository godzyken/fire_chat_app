import 'package:fire_chat_app/app/modules/room/controllers/room_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;


class CreateachatroomController extends GetxController {
  //TODO: Implement CreateachatroomController

  final name = TextEditingController().obs;
  bool? isCreated;


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

  createRoom(String? name, types.User otherUser, BuildContext context) async {
    isCreated = false;
    try {
      var room = RoomController().createRoom(otherUser, context);
      final roomCreate = types.Room(
        id: room!.id,
        name: name,
        users: room.users,
        type: room.type,
        metadata: room.metadata,
        imageUrl: room.imageUrl,
      );

      print('result: ${roomCreate.name}');
      isCreated = true;

      return roomCreate;
    } on Exception catch (e, s) {
      print(s);
      isCreated = false;
    }
  }
}
