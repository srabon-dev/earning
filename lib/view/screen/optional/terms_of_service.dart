import 'package:earning/constant/app_constants.dart';
import 'package:earning/controller/terms_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class TermsOfService extends StatelessWidget {
  TermsOfService({super.key});
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<TermsController>(
          init: TermsController(),
          builder: (logic) {
            return Scaffold(
              appBar: const CustomAppBar(name: "terms_of_use",isBack: true),
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
                    initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(AppConstants.termsUrl))),
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
