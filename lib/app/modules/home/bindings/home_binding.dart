import 'package:fire_chat_app/app/modules/chat/controllers/chat_controller.dart';
import 'package:fire_chat_app/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<SignInController>(() => SignInController());
    Get.lazyPut<ChatController>(() => ChatController());
  }
}
