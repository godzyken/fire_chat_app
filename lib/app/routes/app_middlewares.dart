import 'package:fire_chat_app/app/modules/signIn/bindings/sign_in_binding.dart';
import 'package:fire_chat_app/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:fire_chat_app/app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Middleware extends GetMiddleware {

  @override
  RouteSettings? redirect(String? route) {
    final authService = AuthService();
    return authService.authed.value ? null : RouteSettings(name: '/sign-in');
  }

  @override
  void onPageDispose() {

  }

  @override
  Widget onPageBuilt(Widget page) => page;

  @override
  GetPageBuilder? onPageBuildStart(GetPageBuilder? page) => page;

  @override
  List<Bindings>? onBindingsStart(List<Bindings>? bindings) {
    final authService = Get.find<SignInController>();
    if (authService.logginIn) {
      bindings!.add(SignInBinding());
    }
    return bindings;
  }

  @override
  GetPage? onPageCalled(GetPage? page) => page;
}

