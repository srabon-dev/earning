import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/dependency/dependency_injection.dart';
import 'core/route/app_route.dart';
import 'utils/theme/theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Dependency Injection
  DependencyInjection.init();

  // initialize Firebase
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyAlbv9NGF1b8qPwfQBk_sEvDBsGbzaTju0",
      authDomain: "earning-5ed58.firebaseapp.com",
      projectId: "earning-5ed58",
      storageBucket: "earning-5ed58.appspot.com",
      messagingSenderId: "86670873741",
      appId: "1:86670873741:web:61916de8afad77a25afec4",
      measurementId: "G-YE62LZ4SW8"
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
