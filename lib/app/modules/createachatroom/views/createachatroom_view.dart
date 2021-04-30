import 'package:fire_chat_app/app/modules/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../controllers/createachatroom_controller.dart';

class CreateachatroomView extends GetView<CreateachatroomController> {
  String? get name => controller.name.value.text;

  get label => Text(
        'Add',
        style: TextStyle(fontSize: 20),
        softWrap: true,
        textAlign: TextAlign.center,
      );

  get buildMembers => GetBuilder<UsersController>(
      init: UsersController(),
      builder: (controller) => StreamBuilder<List<types.User>>(
            stream: controller.usersList,
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 200),
                  child: const Text('No users'),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final user = snapshot.data![index];

                    return GestureDetector(
                      onTap: () => controller.handleSelect,
                      child: Container(
                        padding: const EdgeInsets.symmetric(),
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
                                child: Image.network(user.avatarUrl ?? ''),
                              ),
                            ),
                            Text('${user.firstName} ${user.lastName}')
                          ],
                        ),
                      ),
                    );
                  });
            },
          ));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CreateachatroomController>(
        init: CreateachatroomController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                title: Text('Create a chat-room'),
                centerTitle: true,
              ),
              body: Container(
                child: Center(
                  heightFactor: 2.0,
                  widthFactor: 1.0,
                  child: Column(
                      children: <Widget>[
                    Obx(
                      () => TextFormField(
                        decoration: const InputDecoration(
                          focusColor: Colors.amber,
                          labelText: 'Name',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                        controller: controller.name.value,
                        onFieldSubmitted: (value) => controller.createRoom,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                        child: Container(child: buildMembers,)
                    ),
                  ]),
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  controller.isCreated.reactive;
                  controller.createRoom(name, buildMembers, context);
                },
                label: label,
              ),
            ));
  }
}
