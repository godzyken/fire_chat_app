import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInController extends GetxController {
  //TODO: Implement SignInController

  FocusNode? focusNode;
  bool logginIn = false;
  TextEditingController? usernameController;
  TextEditingController? passwordController;


  @override
  void onInit() {
    super.onInit();
    focusNode = FocusNode();
    passwordController = TextEditingController(text: 'Qawsed1-');
    usernameController = TextEditingController(text: '');
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void onClose() {
  }

  void login(context) async {
    logginIn = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController!.text,
          password: passwordController!.text);
      Get.offAllNamed('/room');
    } catch (e) {
      logginIn = false;

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
