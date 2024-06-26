import 'package:earning/view/screen/auth/forget/forget_password.dart';
import 'package:earning/view/screen/auth/intro/auth_screen.dart';
import 'package:earning/view/screen/auth/login/login_screen.dart';
import 'package:earning/view/screen/auth/register/register_screen.dart';
import 'package:earning/view/screen/create/create_post_screen.dart';
import 'package:earning/view/screen/earning/earning_screen.dart';
import 'package:earning/view/screen/edit/edit_post_screen.dart';
import 'package:earning/view/screen/home/home_screen.dart';
import 'package:earning/view/screen/languages/languages_screen.dart';
import 'package:earning/view/screen/message/message_screen.dart';
import 'package:earning/view/screen/nav/nav_screen.dart';
import 'package:earning/view/screen/optional/about_us.dart';
import 'package:earning/view/screen/optional/privacy_policy.dart';
import 'package:earning/view/screen/optional/terms_of_service.dart';
import 'package:earning/view/screen/payment/payment_screen.dart';
import 'package:earning/view/screen/post/my_post_screen.dart';
import 'package:earning/view/screen/profile/edit_profile_screen.dart';
import 'package:earning/view/screen/profile/profile_screen.dart';
import 'package:earning/view/screen/splash/splash_screen.dart';
import 'package:earning/view/screen/verify/verify_screen.dart';
import 'package:earning/view/screen/withdraw/withdraw_screen.dart';
import 'package:get/get.dart';

class AppRoute{

  //Splash
  static const String splashScreen = "/splash_screen";

  //Auth
  static const String authIntroScreen = "/auth_screen";
  static const String loginScreen = "/login_screen";
  static const String registerScreen = "/register_screen";
  static const String forgetPassword = "/forget_password";

  //Nav Bar
  static const String navScreen = "/nav_screen";
  static const String homeScreen = "/home_screen";
  static const String myPostScreen = "/my_post_screen";
  static const String earningScreen = "/earning_screen";
  static const String profileScreen = "/profile_screen";

  //Other
  static const String createPostScreen = "/create_post_screen";
  static const String verifyScreen = "/verify_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String editPostScreen = "/edit_post_screen";
  static const String withdrawScreen = "/withdraw_screen";
  static const String messageScreen = "/message_screen";
  static const String languagesScreen = "/languages_screen";
  static const String paymentScreen = "/payment_screen";
  // static const String favoriteScreen = "/favorite_screen";

  //Optional
  static const String privacyPolicy = "/privacy_policy";
  static const String termsOfService = "/terms_of_service";
  static const String aboutUs = "/about_us";

  static List<GetPage> routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: authIntroScreen, page: () => const AuthScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: registerScreen, page: () => const RegisterScreen()),
    GetPage(name: forgetPassword, page: () => const ForgetPassword()),
    GetPage(name: navScreen, page: () => const NavScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: myPostScreen, page: () => const MyPostScreen()),
    GetPage(name: earningScreen, page: () => const EarningScreen()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
    GetPage(name: createPostScreen, page: () => const CreatePostScreen()),
    GetPage(name: verifyScreen, page: () => const VerifyScreen()),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen()),
    GetPage(name: editPostScreen, page: () => const EditPostScreen()),
    GetPage(name: withdrawScreen, page: () => const WithdrawScreen()),
    GetPage(name: messageScreen, page: () => const MessageScreen()),
    GetPage(name: languagesScreen, page: () => const LanguagesScreen()),
    GetPage(name: paymentScreen, page: () => const PaymentScreen()),
    // GetPage(name: favoriteScreen, page: () => const FavoriteScreen()),
    GetPage(name: privacyPolicy, page: () =>  PrivacyPolicy()),
    GetPage(name: termsOfService, page: () =>  TermsOfService()),
    GetPage(name: aboutUs, page: () => const AboutUs()),
  ];
}
