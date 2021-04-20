import 'package:faker/faker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  String? email;
  String? firstName;
  FocusNode? focusNode;
  String? lastName;
  bool registering = false;
  TextEditingController? passwordController;
  TextEditingController? usernameController;

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();


  @override
  void onInit() {
    super.onInit();
    final faker = Faker();
    firstName = faker.person.firstName();
    lastName = faker.person.lastName();
    email =
    '${firstName!.toLowerCase()}.${lastName!.toLowerCase()}@${faker.internet.domainName()}';
    focusNode = FocusNode();
    passwordController = TextEditingController(text: 'Qwased1-');
    usernameController = TextEditingController(text: email);

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void>? register(context) async {
    FocusScope.of(context).unfocus();
    final init = await _initialization;
    registering = true;

    try {
      init.isAutomaticDataCollectionEnabled;
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController!.text,
        password: passwordController!.text,
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          avatarUrl: 'https://i.pravatar.cc/300?u=$email',
          firstName: firstName,
          id: credential.user!.uid,
          lastName: lastName,
        ),
      );
      Get.to(context);

    } catch (e) {
      registering = false;

      await showDialog(context: context,
        builder: (context) =>
            AlertDialog(
              actions: [
                TextButton(onPressed: () => Get.back(),
                  child: const Text('OK'),
                ),
              ],
              content: Text(e.toString()),
              title: const Text('Error'),
            ),
      );
    }
  }

}
