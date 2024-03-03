import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  final Connectivity connectivity = Connectivity();
  @override
  void onInit() {
    super.onInit();
    connectivity.onConnectivityChanged.listen((ConnectivityResult connectivityResult) async{
      if(connectivityResult == ConnectivityResult.none){
        Fluttertoast.showToast(msg: "Please Check Internet Connection");
      }
    });
  }
}