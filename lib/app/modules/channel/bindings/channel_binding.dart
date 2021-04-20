import 'package:get/get.dart';

import '../controllers/channel_controller.dart';

class ChannelBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChannelController>(
      () => ChannelController(),
    );
  }
}
