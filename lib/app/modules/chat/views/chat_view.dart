import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

import 'package:get/get.dart';

import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  get context => BuildContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ChatView'),
          centerTitle: true,
        ),
        body: StreamBuilder<List<types.Message>>(
            stream:
                FirebaseChatCore.instance.messages(controller.rooms!.single.id),
            initialData: const [],
            builder: (context, snapshot) {
              return Chat(
                l10n: const ChatL10nEn(
                  inputPlaceholder: 'Here',
                ),
                isAttachmentUploading: controller.isAttachmentUploading,
                onSendPressed: (c) => controller.onSendPressed,
                messages: controller.messages!,
                onAttachmentPressed: _handleAtachmentPressed,
                onFilePressed: (c) => controller.openFile,
                onPreviewDataFetched: controller.onPreviewDataFetched,
                user: controller.user,
                theme: const DefaultChatTheme(inputBackgroundColor: Colors.red),
              );
            }));
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    // controller.handleImageSelection();
                    controller.showImagePicker();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // controller.handleFileSelection();
                    controller.showFilePicker();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Get.toNamed('/home'),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
