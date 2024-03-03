import 'package:earning/controller/internet_controller.dart';
import 'package:get/get.dart';

class DependencyInjection{
  static void init(){
    Get.put<InternetController>(InternetController(),permanent: true);
  }
}