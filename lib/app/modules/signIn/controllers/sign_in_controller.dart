import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:firebase_auth/firebase_auth.dart';

class SignInController extends GetxController {
  static SignInController? to = Get.find();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  Rxn<User?> firebaseUser = Rxn<User>();
  Rxn<types.User?>? firestoreUser = Rxn<types.User>();

  FocusNode? focusNode;
  bool logginIn = false;
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  Stream<types.User?>? streamFirestoreUser() {
    print('streamFirestoreUser()');
    if (firebaseUser.value?.uid != null) {
      return FirebaseFirestore.instance
          .doc('/users/${firebaseUser.value!.uid}')
          .snapshots()
          .map((snapshot) => types.User(id: snapshot.id));
    }

    return null;
  }

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> get getUser async {
    return _auth.currentUser;
  }

  Future<types.User?>? getFirestoreUser() {
    if (firebaseUser.value?.uid != null) {
      return _db.doc('/users/${firebaseUser.value!.uid}')
          .get().then((snapshot) => types.User(id: snapshot.id));
    }
    update();
    return null;
  }

  Future<void> updateUser(BuildContext context, types.User user,
      String oldEmail,
      String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: oldEmail, password: password)
          .then((_firebaseUser) {
        _firebaseUser.user!
            .updateEmail(user.firstName!)
            .then((value) => _updateUserFirestore(user, _firebaseUser.user!));
      });

      Get.snackbar('update User Success Notice Title',
          'update User Success',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    } on PlatformException catch (error) {
      //List<String> errors = error.toString().split(',');
      // print("Error: " + errors[1]);
      print(error.code);
      String? authError;
      switch (error.code) {
        case 'ERROR_WRONG_PASSWORD':
          authError = 'Wrong Password Notice';
          break;
        default:
          authError = 'unknown Error';
          break;
      }
      Get.snackbar('Wrong Password Notice Title', authError,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor!,
          colorText: Get.theme.snackBarTheme.actionTextColor!);
    }
  }

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(user);

    focusNode = FocusNode();
    passwordController = TextEditingController(text: 'dattebayo');
    usernameController = TextEditingController(text: 'isgodzy@gmail.com');
  }

  @override
  void onReady() async {
    super.onReady();
    ever(firebaseUser, handleAuthChanged);
    firebaseUser.value = await getUser;
    firebaseUser.bindStream(user);
  }

  @override
  void onClose() {
    usernameController!.dispose();
    passwordController!.dispose();
    super.onClose();
  }

  login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: usernameController!.text,
          password: passwordController!.text
      );
      logginIn = true;
      usernameController!.clear();
      passwordController!.clear();

      Get.offAllNamed('/room');
    } on FirebaseAuthException catch (e) {
      logginIn = false;

      await showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
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
      firestoreUser!.bindStream(streamFirestoreUser()!);
    }

    if (_firebaseUser == null) {
      Get.toNamed('/sign-in');
    } else {
      Get.toNamed('/home');
    }
  }

  getProfileImage() {}

  getAvatar() {
    if (_auth.currentUser!.photoURL != null) {
      return Image.network(
        _auth.currentUser!.photoURL!,
        height: 100,
        width: 100,
      );
    } else {
      return Icon(Icons.account_circle, size: 100,);
    }
  }

  _updateUserFirestore(types.User user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}')
        .update(user.metadata!);
    update();
  }
}
