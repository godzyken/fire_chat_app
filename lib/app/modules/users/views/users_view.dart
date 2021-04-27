import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

import '../controllers/users_controller.dart';

class UsersView extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        brightness: Brightness.dark,
        // leading: IconButton(
        //   onPressed: ,
        //   icon: ,
        //   focusColor: ,
        // ),
      ),
      body: FirebaseChatCore.instance.firebaseUser == null
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(bottom: 200),
              child: const Text('No Users'),
            )
          : GetBuilder(
              builder: (UsersController controller) =>
                  StreamBuilder<List<types.User>>(
                    stream: FirebaseChatCore.instance.users(),
                    initialData: const [],
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
                              onTap: () =>
                                  controller.handlePressed(user, context),
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
                                        child:
                                            Image.network(user.avatarUrl ?? ''),
                                      ),
                                    ),
                                    Text('${user.firstName} ${user.lastName}')
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/home'),
        child: Text('Home'),
      ),
    );
  }
}
