import 'package:earning/view/screen/auth/forget/forget_password.dart';
import 'package:earning/view/screen/auth/login/login_screen.dart';
import 'package:earning/view/screen/auth/register/register_screen.dart';
import 'package:earning/view/screen/create/create_post_screen.dart';
import 'package:earning/view/screen/nav/nav_screen.dart';
import 'package:earning/view/screen/post/my_post_screen.dart';
import 'package:earning/view/screen/splash/splash_screen.dart';
import 'package:earning/view/screen/verify/verify_screen.dart';
import 'package:get/get.dart';

class AppRoute{
  static const String splashScreen = "/splash_screen";
  static const String loginScreen = "/login_screen";
  static const String registerScreen = "/register_screen";
  static const String forgetPassword = "/forget_password";
  static const String navScreen = "/nav_screen";
  static const String myPostScreen = "/my_post_screen";
  static const String createPostScreen = "/create_post_screen";
  static const String verifyScreen = "/verify_screen";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: navScreen, page: () => const NavScreen()),
    GetPage(name: myPostScreen, page: () => const MyPostScreen()),
    GetPage(name: createPostScreen, page: () => const CreatePostScreen()),
    GetPage(name: verifyScreen, page: () => const VerifyScreen()),
  ];
}
