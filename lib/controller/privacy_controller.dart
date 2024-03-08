import 'package:earning/constant/error_html_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController{
  InAppWebViewController? inAppWebViewController;
  PullToRefreshController? pullToRefreshController;
  bool isWebViewLoading = false;

  //When Web View Create This Function Call
  void isWebViewCreatedFunction(InAppWebViewController controller){
    inAppWebViewController = controller;
    update();
  }

  void onWebViewProgressChange(InAppWebViewController controller, int value){
    final double progress = value / 100;
    if(progress < 1.0){
      isWebViewLoading = true;
      update();
    }else{
      isWebViewLoading = false;
      update();
    }
  }

  void onWebViewReceiveError (InAppWebViewController controller, WebResourceRequest request, WebResourceError error){
    var isForMainFrame = request.isForMainFrame ?? false;
    if (!isForMainFrame || (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS && error.type == WebResourceErrorType.CANCELLED)) {
      return;
    }
    var errorUrl = request.url;
    controller.loadData(data: errorHtmlText, baseUrl: errorUrl, historyUrl: errorUrl);
  }
}