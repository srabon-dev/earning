import 'package:earning/constant/app_constants.dart';
import 'package:earning/controller/privacy_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PrivacyController>(
        init: PrivacyController(),
        builder: (logic) {
          return Scaffold(
            appBar: const CustomAppBar(name: "Privacy Policy",isBack: true),
            body: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  onWebViewCreated: logic.isWebViewCreatedFunction,
                  onReceivedError: logic.onWebViewReceiveError,
                  onProgressChanged: logic.onWebViewProgressChange,
                  initialSettings: InAppWebViewSettings(
                    disableDefaultErrorPage: true,
                    cacheEnabled: true,
                    javaScriptEnabled: true,
                  ),
                  initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(AppConstants.privacyUrl))),
                ),
                if(logic.isWebViewLoading)
                  const Center(child: CircularProgressIndicator(),),
              ],
            ),
          );
        }
      ),
    );
  }
}
