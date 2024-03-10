import 'package:earning/controller/internet_controller.dart';
import 'package:earning/controller/languages_controller.dart';
import 'package:get/get.dart';

class DependencyInjection{
  static void init(){
    Get.put<InternetController>(InternetController(),permanent: true);
    Get.put<LocalizationController>(LocalizationController(),permanent: true);
  }
}