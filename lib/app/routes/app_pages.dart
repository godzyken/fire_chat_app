import 'package:fire_chat_app/app/routes/app_middlewares.dart';
import 'package:get/get.dart';

import 'package:fire_chat_app/app/modules/channel/bindings/channel_binding.dart';
import 'package:fire_chat_app/app/modules/channel/views/channel_view.dart';
import 'package:fire_chat_app/app/modules/chat/bindings/chat_binding.dart';
import 'package:fire_chat_app/app/modules/chat/views/chat_view.dart';
import 'package:fire_chat_app/app/modules/createachatroom/bindings/createachatroom_binding.dart';
import 'package:fire_chat_app/app/modules/createachatroom/views/createachatroom_view.dart';
import 'package:fire_chat_app/app/modules/games/bindings/games_binding.dart';
import 'package:fire_chat_app/app/modules/games/views/games_view.dart';
import 'package:fire_chat_app/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_app/app/modules/home/views/home_view.dart';
import 'package:fire_chat_app/app/modules/profile/bindings/profile_binding.dart';
import 'package:fire_chat_app/app/modules/profile/views/profile_view.dart';
import 'package:fire_chat_app/app/modules/room/bindings/room_binding.dart';
import 'package:fire_chat_app/app/modules/room/views/room_view.dart';
import 'package:fire_chat_app/app/modules/signIn/bindings/sign_in_binding.dart';
import 'package:fire_chat_app/app/modules/signIn/views/sign_in_view.dart';
import 'package:fire_chat_app/app/modules/signUp/bindings/sign_up_binding.dart';
import 'package:fire_chat_app/app/modules/signUp/views/sign_up_view.dart';
import 'package:fire_chat_app/app/modules/splash/bindings/splash_binding.dart';
import 'package:fire_chat_app/app/modules/splash/views/splash_view.dart';
import 'package:fire_chat_app/app/modules/users/bindings/users_binding.dart';
import 'package:fire_chat_app/app/modules/users/views/users_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        bindings: [HomeBinding(), SignInBinding()],
        middlewares: [
          Middleware(),
        ],
        maintainState: true),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.GAMES,
      page: () => GamesView(),
      bindings: [GamesBinding(), SignInBinding()],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      bindings: [ProfileBinding(), SignInBinding()],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatView(),
      bindings: [ChatBinding(), SignInBinding()],
    ),
    GetPage(
      name: _Paths.CHANNEL,
      page: () => ChannelView(),
      bindings: [ChannelBinding(), SignInBinding()],
    ),
    GetPage(
      name: _Paths.ROOM,
      page: () => RoomView(),
      bindings: [RoomBinding(), SignInBinding()],
    ),
    GetPage(
      name: _Paths.USERS,
      page: () => UsersView(),
      bindings: [UsersBinding(), SignInBinding()],
    ),
    GetPage(
      name: _Paths.CREATEACHATROOM,
      page: () => CreateachatroomView(),
      binding: CreateachatroomBinding(),
    ),
  ];
}
