import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

class RoomController extends GetxController {

  bool? error = false;
  bool initialized = false;
  User? user;

  List<types.Room>? room;
  List<types.User>? users;

  @override
  void onInit() {
    super.onInit();
    initializeFlutterFire();
    
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      FirebaseAuth.instance.authStateChanges().listen((User? _user) {
        user = _user;
      });

      initialized = true;
      update();

    } catch (e) {
      error = true;
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
  }

}
