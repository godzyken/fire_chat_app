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
  TextEditingController? firstnameController;
  TextEditingController? lastnameController;
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
    firstnameController = TextEditingController(text: firstName);
    lastnameController = TextEditingController(text: lastName);
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
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      registering = false;

      if (e.code == 'account-exists-with-different-credential') {
        String email = e.email!;
        AuthCredential pendingCredential = e.credential!;

        List<String>? userSignInMethods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (userSignInMethods.first == 'password') {
          String password = '...';

          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);

          await userCredential.user!.linkWithCredential(pendingCredential);

          return Get.toNamed('/home');
        }

        if (userSignInMethods.first == 'facebook.com') {
          String accessToken = '...';
          FacebookAuthCredential? facebookAuthCredential =
              FacebookAuthProvider.credential(accessToken) as FacebookAuthCredential?;

          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookAuthCredential!);

          await userCredential.user!.linkWithCredential(pendingCredential);

          return Get.toNamed('/home');
        }

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
  }

  getProfileImage() {
    if (FirebaseAuth.instance.currentUser!.photoURL != null){
      return Image.network(FirebaseAuth.instance.currentUser!.photoURL!, height: 100, width: 100,);
    } else {
      return Icon(Icons.account_circle, size: 100);
    }
  }

  getAvatar() {}


}
