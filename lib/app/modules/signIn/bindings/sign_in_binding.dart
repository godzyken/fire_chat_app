import 'package:fire_chat_app/app/services/auth_service.dart';
import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
      () => SignInController(),
    );

    Get.put<AuthService>(AuthService(), tag: 'authed', permanent: true);
  }
}
