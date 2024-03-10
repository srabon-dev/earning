import 'package:earning/constant/app_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constant/message.dart';
import 'controller/languages_controller.dart';
import 'core/dependency/dependency_injection.dart';
import 'core/route/app_route.dart';
import 'utils/theme/theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injection
  DependencyInjection.init();

  // initialize Firebase
  await Firebase.initializeApp();

  //Localization
  Map<String, Map<String, String>> languages = await LocalizationController.getLanguages();

  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.languages});
  final Map<String, Map<String, String>>? languages;
  @override
  Widget build(BuildContext context) {

    return GetBuilder<LocalizationController>(
      builder: (localizeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 200),

          //Route Section
          initialRoute: AppRoute.splashScreen,
          navigatorKey: Get.key,
          getPages: AppRoute.routes,

          //Theme Section
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,

          //Languages Section
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode),
        );
      }
    );
  }
}
