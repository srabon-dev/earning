import 'package:earning/view/screen/auth/forget/forget_password.dart';
import 'package:earning/view/screen/auth/login/login_screen.dart';
import 'package:earning/view/screen/auth/register/register_screen.dart';
import 'package:earning/view/screen/nav/nav_screen.dart';
import 'package:earning/view/screen/post/video_post_screen.dart';
import 'package:earning/view/screen/splash/splash_screen.dart';
import 'package:earning/view/screen/video/video_screen.dart';
import 'package:get/get.dart';

class AppRoute{
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String registerScreen = "/register_screen";
  static const String forgetPassword = "/forget_password";
  static const String navScreen = "/nav_screen";
  static const String myVideoScreen = "/video_screen";
  static const String videoPostScreen = "/video_post_screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: navScreen, page: () => const NavScreen()),
    GetPage(name: myVideoScreen, page: () => const MyVideoScreen()),
    GetPage(name: videoPostScreen, page: () => const VideoPostScreen()),
  ];
}
