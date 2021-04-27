
import 'package:fire_chat_app/app/modules/home/bindings/home_binding.dart';
import 'package:fire_chat_app/app/modules/home/views/home_view.dart';
import 'package:fire_chat_app/app/themes/app_theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/routes/app_pages.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();

  await Firebase.initializeApp();

  // await initialBindingServices();
  //
 /* try {

  } catch (exception, stackTrace) {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
    );
  }
*/
  await SentryFlutter.init((options) {
    options.dsn =
    'https://a4c44e2b1e9c4a52bfffadde11beed5b@o573314.ingest.sentry.io/5723721';
    options.debug = true;
    options.useFlutterBreadcrumbTracking();
    options.autoSessionTrackingIntervalMillis;
  },
      appRunner: () async =>
       /*   await initializeDateFormatting('en_US', '/').then((_) =>*/ runApp(
               GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  smartManagement: SmartManagement.onlyBuilder,
                  enableLog: true,
                  initialRoute: AppPages.INITIAL,
                  locale: Get.locale,
                  getPages: AppPages.routes,
                  initialBinding: HomeBinding(),
                  darkTheme: ThemeData.dark(),
                  themeMode: AppThemeData.INITIAL,
              )
          // ),
  ));
}
