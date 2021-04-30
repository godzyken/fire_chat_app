import 'package:fire_chat_app/app/modules/room/controllers/room_controller.dart';
import 'package:fire_chat_app/app/modules/users/controllers/users_controller.dart';
import 'package:get/get.dart';

import '../controllers/createachatroom_controller.dart';

class CreateachatroomBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<CreateachatroomController>(
      () => CreateachatroomController(), tag: 'name'
    );
    Get.lazyPut<RoomController>(() => RoomController());
    Get.lazyPut<UsersController>(() => UsersController());
  }
}
