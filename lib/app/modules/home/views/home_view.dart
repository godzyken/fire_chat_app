import 'package:fire_chat_app/app/modules/room/controllers/room_controller.dart';
import 'package:fire_chat_app/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:fire_chat_app/app/modules/users/controllers/users_controller.dart';
import 'package:fire_chat_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  get label => Text(
        'Rooms',
        style: TextStyle(fontSize: 20),
        softWrap: true,
        textAlign: TextAlign.center,
      );

  get gridDelegate => SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 200,
      childAspectRatio: 3 / 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20);

  get itemBuilder => (BuildContext ctx, index) => GridTile(
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(15),
            ),
            child: GetBuilder<UsersController>(
              global: true,
              init: UsersController(),
              builder: (controller) => futureBuilder,
            )),
      );

  get futureBuilder => GetBuilder<RoomController>(
      init: RoomController(),
      builder: (controller) => StreamBuilder<List<types.Room>>(
          stream: FirebaseChatCore.instance.rooms(),
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final rooms = snapshot.data!;

              return ListView.builder(
                itemCount: rooms.lastIndexOf(rooms.last),
                itemBuilder: (context, index) {
                  final room = rooms[index];

                  return GestureDetector(
                    onTap: () => Get.toNamed('/chat', arguments: room.id),
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
                              child: Image.network(room.imageUrl ?? ''),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Text("Done");
            }

            return Text("loading");
          }));

  get itemCount => RoomController().counter;

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
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
              ),
            )
          : SafeArea(
              child: GridView.builder(
                gridDelegate: gridDelegate,
                itemBuilder: itemBuilder,
                itemCount: itemCount,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.manual,
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/room',
            preventDuplicates: true, arguments: AppPages()),
        label: label,
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
