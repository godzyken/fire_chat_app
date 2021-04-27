import 'package:get/get.dart';

import '../controllers/createachatroom_controller.dart';

class CreateachatroomBinding extends Bindings {
  @override
  void dependencies() {
    Get.create<CreateachatroomController>(
      () => CreateachatroomController(),
    );
    Get.put<CreateachatroomController>(CreateachatroomController(), tag: 'name');
  }
}
