import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

class AuthService extends GetxService {
  FirebaseAuth? auth = FirebaseAuth.instance;

  get authed => handleAuthChanged();

  handleAuthChanged() async {
    try{
      auth!.authStateChanges().listen((event) {
        event!.uid.isEmpty ? event.getIdTokenResult(true) : auth!.currentUser;
        return print('user is signed in! $event');
      });
    } on FirebaseAuthException catch (e, s) {
      print(s);
    }
  }

  handleSetPersistence() async {
    try{
      auth!.setPersistence(Persistence.SESSION);
    } on FirebaseAuthException catch (e, s) {
      print(s);
    }
  }

  handleSignInMethods() async {

  }

  @override
  void onClose() {

  }

  @override
  void onReady() {

  }

  @override
  void onInit() {

  }
}