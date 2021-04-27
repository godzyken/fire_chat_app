import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:sentry_flutter/sentry_flutter.dart';
import '../controllers/room_controller.dart';

class RoomView extends GetView<RoomController> {
  get label => Text(
    'Create a Room',
    style: TextStyle(fontSize: 20),
    softWrap: true,
    textAlign: TextAlign.center,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rooms'),
          centerTitle: true,
          brightness: Brightness.dark,
        ),
        body: FirebaseChatCore.instance.firebaseUser == null
            ? Container(
                child: Center(
                child: CircularProgressIndicator.adaptive(
                  backgroundColor: RenderErrorBox.backgroundColor,
                  strokeWidth: 4.0,
                ),
              ))
            : GetBuilder(
                builder: (RoomController controller) =>
                    StreamBuilder<List<types.Room>>(
                        stream: FirebaseChatCore.instance.rooms(),
                        initialData: const [],
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Container(
                              alignment: Alignment.center,
                              margin: const EdgeInsets.only(
                                bottom: 200,
                              ),
                              child: const Text('No rooms'),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final room = snapshot.data![index];

                              return GestureDetector(
                                onTap: () =>
                                    Get.toNamed('/chat', arguments: room.id),
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
                                          child: Image.network(
                                              room.imageUrl ?? ''),
                                        ),
                                      ),
                                      Text('${room.name} ${room.type}'),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/createachatroom'),
          label: label,
      ),
    );
  }
}