import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/error_html_text.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController{
  
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool isPaymentLoading = false;
  bool isError = false;
  bool isWebLoading = false;
  InAppWebViewController? inAppWebViewController;
  String? paymentUrl;
  
  Future<void> getPaymentUrl() async{
    try{
      isLoading = true;
      isError = false;
      update();
      firestore.collection("basic").doc("payment").get().then((value){
        paymentUrl = value.data()?['url']??"";
        isLoading = false;
        isError = false;
        update();
      }).onError((error, stackTrace){
        isLoading = false;
        isError = true;
        update();
      });
    }catch(error){
      isLoading = false;
      isError = true;
      update();
    }
  }

  //When Web View Create This Function Call
  void isWebViewCreatedFunction(InAppWebViewController controller) {
    inAppWebViewController = controller;
    update();
  }

  void onUpdateVisitedHistory(InAppWebViewController inAppWebViewController, WebUri? webUri, bool? isTrue){
    if(webUri?.pathSegments.last == "payment-success"){
      isPaymentLoading = true;
      update();
      firestore.collection("user").doc(auth.currentUser?.uid??"").update({
        'isVerified': true,
        'verificationStatus': "Active",
        'createdAt': FieldValue.serverTimestamp(),
      }).then((value){
        isPaymentLoading = false;
        update();
        Future.delayed(const Duration(seconds: 1),(){
          Get.offAllNamed(AppRoute.navScreen);
        });
      }).onError((error, stackTrace){
        firestore.collection("basic").doc("payment").collection("paymentField").doc(auth.currentUser?.email??"").set({
          "id": auth.currentUser?.uid,
          "paymentUrl": paymentUrl,
          "lastPath": webUri?.pathSegments.last,
          "email": auth.currentUser?.email,
          'createdAt': FieldValue.serverTimestamp(),
        }).then((value){
          isPaymentLoading = false;
          update();
          Future.delayed(const Duration(seconds: 1),(){
            Get.offAllNamed(AppRoute.navScreen);
          });
        }).onError((error, stackTrace){
          Fluttertoast.showToast(msg: "verification_problem".tr);
        });
      });
    }
  }

  void onWebViewProgressChange(InAppWebViewController controller, int value) {
    final double progress = value / 100;
    if (progress < 1.0) {
      isWebLoading = true;
      update();
    } else {
      isWebLoading = false;
      update();
    }
  }

  void onWebviewLoadStop(InAppWebViewController controller, WebUri? url) {

  }

  void onWebViewReceiveError(InAppWebViewController controller,
      WebResourceRequest request, WebResourceError error) {
    var isForMainFrame = request.isForMainFrame ?? false;
    if (!isForMainFrame ||
        (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS &&
            error.type == WebResourceErrorType.CANCELLED)) {
      return;
    }
    var errorUrl = request.url;
    controller.loadData(
        data: errorHtmlText, baseUrl: errorUrl, historyUrl: errorUrl);
  }

  @override
  void onInit() {
    Future.wait([getPaymentUrl()]);
    super.onInit();
  }
}