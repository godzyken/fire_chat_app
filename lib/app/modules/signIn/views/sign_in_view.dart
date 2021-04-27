import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignInView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          restorationId: 'fire_chat_app',
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
            child: Column(
              children: [
                Container(
                  child: CircularProfileAvatar(
                    '',
                    imageBuilder: (context, imageProvider) => controller.getProfileImage(),
                    child: Icon(
                      Icons.person,
                      size: 140,
                    ),
                    cacheImage: true,
                    onTap: () => controller.getAvatar(),
                    animateFromOldImageOnUrlChange: true,
                    borderColor: Colors.purpleAccent,
                    borderWidth: 3,
                    elevation: 5,
                    radius: 75,
                  ),
                ),
                TextField(
                  autocorrect: false,
                  autofillHints:
                      controller.logginIn ? null : [AutofillHints.email],
                  autofocus: true,
                  controller: controller.usernameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                    ),
                    labelText: 'Email',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () => controller.usernameController?.clear(),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    controller.focusNode?.requestFocus();
                  },
                  readOnly: controller.logginIn,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autocorrect: false,
                    autofillHints:
                        controller.logginIn ? null : [AutofillHints.password],
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => controller.passwordController?.clear(),
                      ),
                    ),
                    focusNode: controller.focusNode,
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    onEditingComplete: controller.onReady,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                TextButton(
                  onPressed:
                      controller.logginIn ? null : () => controller.login(context),
                  child: const Text('Login'),
                ),
                TextButton(
                  onPressed: controller.logginIn
                      ? null
                      : () => Get.toNamed('/sign-up'),
                  child: const Text('No Have One ??'),
                ),
              ],
            ),
          ),
        ));
  }
}
