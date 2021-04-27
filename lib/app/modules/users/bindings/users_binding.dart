import 'package:fire_chat_app/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersController>(
      () => UsersController(),
    );
    Get.lazyPut<SignInController>(() => SignInController(), tag: 'logginIn');
  }
}
