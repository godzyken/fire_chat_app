import 'package:fire_chat_app/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

import '../controllers/room_controller.dart';

class RoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomController>(
      () => RoomController(),
    );
    Get.lazyPut<SignInController>(() => SignInController(), tag: 'auth!');
  }
}
