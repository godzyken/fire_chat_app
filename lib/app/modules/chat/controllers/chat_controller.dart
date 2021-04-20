import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;



class ChatController extends GetxController {
  List<types.Message>? messages = [];
  List<types.Room>? rooms = [];
  bool isAttachmentUploading = false;

  final user = const types.User(id: '06c33e8b-e835-4736-80f4-63f44b66666c');

  @override
  void onInit() {
    super.onInit();
    _loadMessages();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void _addMessage(types.Message? message) {
    messages!.insert(0, message!);
    update();
  }

  handleFilePressed(types.FileMessage? message) async {
    await OpenFile.open(message!.uri);
  }

  handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
    if (result != null) {
      final message = types.FileMessage(
        authorId: user.id,
        fileName: result.files.single.name ?? '',
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path ?? ''),
        size: result.files.single.size ?? 0,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        uri: result.files.single.path ?? '',
      );
      _addMessage(message);
    } else {
      // User canceled the piker
    }
  }

  handleImageSelection() async {
    final result = await ImagePicker().getImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );
    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageName = result.path.split('/').last;

      final message = types.ImageMessage(
        authorId: user.id,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        imageName: imageName,
        size: bytes.length,
        timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
        uri: result.path,
        width: image.width.toDouble(),
      );
      _addMessage(message);
      update();
    } else {
      // User canceled the picker
    }
  }

  handlePreviewDataFetched(
    types.TextMessage? message,
    types.PreviewData? previewData,
  ) {
    final index = messages!.indexWhere((element) => element.id == message!.id);
    final currentMessage = messages![index] as types.TextMessage;
    final updatedMessage = currentMessage.copyWith(previewData!);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      messages![index] = updatedMessage;
    });
  }

  handleSendPressed(types.PartialText? message) {
    final textMessage = types.TextMessage(
      authorId: user.id,
      id: const Uuid().v4(),
      text: message!.text,
      timestamp: (DateTime.now().millisecondsSinceEpoch / 1000).floor(),
    );
    _addMessage(textMessage);
  }

  void _loadMessages() async {
    final response = await rootBundle.loadString('assets/message.json');
    final messagesList = (jsonDecode(response) as List)
        .map((e) => types.Message.fromJson(e as Map<String, dynamic>))
        .toList();
    messages = messagesList;
    update();
  }

  onPreviewDataFetched(types.TextMessage message, types.PreviewData previewData) {
    final updatedMessage = message.copyWith(previewData);
    FirebaseChatCore.instance.updateMessage(updatedMessage, rooms!.single.id);
  }

  onSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(message, rooms!.single.id);
  }

  openFile(types.FileMessage message) async {
    var localPath = message.uri;

    if (message.uri.startsWith('http')) {
      final client = http.Client();
      final request = await client.get(Uri.parse(message.uri));
      final bytes = request.bodyBytes;
      final documentsDir = (await getApplicationDocumentsDirectory()).path;
      localPath = '$documentsDir/${message.fileName}';

      if (!File(localPath).existsSync()) {
        final file = File(localPath);
        await file.writeAsBytes(bytes);
      }
    }

    await OpenFile.open(localPath);
  }

  setAttachmentUploading(bool uploading) {
    isAttachmentUploading = uploading;
  }

  showFilePicker() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null) {
      setAttachmentUploading(true);
      final fileName = result.files.single.name;
      final filePath = result.files.single.path;
      final file = File(filePath ?? '');

      try {
        final reference = FirebaseStorage.instance.ref(fileName);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialFile(
          fileName: fileName ?? '',
          mimeType: lookupMimeType(filePath ?? ''),
          size: result.files.single.size ?? 0,
          uri: uri,
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          rooms!.single.id,
        );
        setAttachmentUploading(false);
      } on FirebaseException catch (e) {
        setAttachmentUploading(false);
        print(e);
      }
    } else {
      // User canceled the picker
    }
  }

  showImagePicker() async {
    final result = await ImagePicker().getImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      setAttachmentUploading(true);
      final file = File(result.path);
      final size = file.lengthSync();
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);
      final imageName = result.path.split('/').last;

      try {
        final reference = FirebaseStorage.instance.ref(imageName);
        await reference.putFile(file);
        final uri = await reference.getDownloadURL();

        final message = types.PartialImage(
          height: image.height.toDouble(),
          imageName: imageName,
          size: size,
          uri: uri,
          width: image.width.toDouble(),
        );

        FirebaseChatCore.instance.sendMessage(
          message,
          rooms!.single.id,
        );
        setAttachmentUploading(false);
      } on FirebaseException catch (e) {
        setAttachmentUploading(false);
        print(e);
      }
    } else {
      // User canceled the picker
    }
  }

  Future<Directory> getApplicationDocumentsDirectory() async {
    final String? path = await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      throw MissingPluginException(
        'Unable to get application documents directory'
      );
    }
    return Directory(path);
  }

}
