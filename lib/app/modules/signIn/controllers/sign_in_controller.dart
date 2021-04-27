import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';

class SignInController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  FocusNode? focusNode;
  bool logginIn = false;
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  Stream<types.User?>? streamFirestoreUser() {
    if (_firebaseUser.value?.uid != null) {
      return FirebaseFirestore.instance
          .doc('/users/${_firebaseUser.value!.uid}')
          .snapshots()
          .map((snapshot) => types.User(id: snapshot.id));
    }

    return null;
  }

  Stream<User?> get user => _auth.authStateChanges();

  @override
  void onInit() {
    super.onInit();
    _firebaseUser.bindStream(_auth.authStateChanges());

    focusNode = FocusNode();
    passwordController = TextEditingController(text: 'dattebayo');
    usernameController = TextEditingController(text: 'isgodzy@gmail.com');
  }

  @override
  void onReady() async {
    super.onReady();
    ever(_firebaseUser, handleAuthChanged);

    _firebaseUser.bindStream(user);
  }

  @override
  void onClose() {
    usernameController!.dispose();
    passwordController!.dispose();
    super.onClose();
  }

  void login(context) async {
    logginIn = true;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController!.text, password: passwordController!.text);
      Get.offAllNamed('/room');
    } on FirebaseAuthException catch (e) {
      logginIn = false;

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
          content: Text(e.toString()),
          title: const Text('Error'),
        ),
      );
    }
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      _firebaseUser.bindStream(streamFirestoreUser()!);
    }

    if (_firebaseUser == null) {
      Get.offAllNamed('/sign-in');
    } else {
      Get.offAllNamed('/home');
    }
  }

  getProfileImage() {}

  getAvatar() {}
}
