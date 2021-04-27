import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/createachatroom_controller.dart';

class CreateachatroomView extends GetView<CreateachatroomController> {
  String? get name => controller.name.value.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a chat-room'),
        centerTitle: true,
      ),
      body: Center(
        heightFactor: 2.0,
        widthFactor: 1.0,
        child: Obx(
          () => TextFormField(
            controller: controller.name.value,
            onEditingComplete: () => controller.createRoom(name),
            onTap: () => controller.createRoom(name),
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.isCreated.reactive;
          controller.createRoom(name);
        },
      ),
    );
  }
}
