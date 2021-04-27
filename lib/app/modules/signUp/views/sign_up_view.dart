import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('SignUpView'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
            child: Column(
              children: [
                Container(
                  child: CircularProfileAvatar(
                    '',
                    imageBuilder: (context, imageProvider) =>
                        controller.getProfileImage(),
                    child: Icon(
                      Icons.person,
                      size: 140,
                    ),
                    cacheImage: true,
                    onTap: () => controller.getAvatar(),
                    borderColor: Colors.purpleAccent,
                    borderWidth: 3,
                    elevation: 5,
                    radius: 75,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autocorrect: false,
                    autofillHints: controller.registering
                        ? null
                        : [AutofillHints.username],
                    controller: controller.firstnameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      labelText: 'FirstName',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () =>
                            controller.firstnameController?.clear(),
                      ),
                    ),
                    focusNode: controller.focusNode,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    onEditingComplete: () =>
                        controller.focusNode!.requestFocus(),
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autocorrect: false,
                    autofillHints:
                        controller.registering ? null : [AutofillHints.name],
                    controller: controller.lastnameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      labelText: 'LastName',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel),
                        onPressed: () => controller.lastnameController?.clear(),
                      ),
                    ),
                    focusNode: controller.focusNode,
                    keyboardType: TextInputType.name,
                    obscureText: false,
                    onEditingComplete: () =>
                        controller.focusNode!.requestFocus(),
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autocorrect: false,
                    autofillHints:
                        controller.registering ? null : [AutofillHints.email],
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
                    onEditingComplete: () =>
                        controller.focusNode?.requestFocus(),
                    readOnly: controller.registering,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    autocorrect: false,
                    autofillHints: controller.registering
                        ? null
                        : [AutofillHints.password],
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
                    onEditingComplete: () => controller.register(context),
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.none,
                  ),
                ),
                TextButton(
                    onPressed: controller.registering
                        ? null
                        : () => controller.register(context),
                    child: const Text('Register')),
              ],
            ),
          ),
        ));
  }
}
