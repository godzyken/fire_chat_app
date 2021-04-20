import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/room_controller.dart';

class RoomView extends GetView<RoomController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RoomView'),
        centerTitle: true,
      ),
      body: controller.user == null
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                bottom: 200,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not authenticated'),
                  TextButton(
                    onPressed: () => Get.toNamed('/sign-in'),
                    child: const Text('Login'),
                  ),
                ],
              ))
          : GetBuilder(
              id: controller.room,
              assignId: true,
              init: controller,
              builder: (RoomController controller) {
                if (!controller.initialized ||
                    controller.user!.tenantId == null) {
                  return Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      bottom: 200,
                    ),
                    child: const Text('No rooms'),
                  );
                }

                return ListView.builder(
                  itemBuilder: (context, index) {
                    final room = controller.room;

                    return GestureDetector(
                      onTap: () => Get.toNamed('/chat', arguments: room),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              margin: const EdgeInsets.only(
                                right: 16,
                              ),
                              width: 40,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                child: Image.network(room!.single.imageUrl ?? ''),
                              ),
                            ),
                            Text(room.single.name ?? 'Room'),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
