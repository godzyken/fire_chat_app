import 'package:fire_chat_app/app/modules/room/controllers/room_controller.dart';
import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(
      () => ChatController(),
    );
    Get.lazyPut<RoomController>(() => RoomController());
  }
}
