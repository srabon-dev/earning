import 'package:earning/constant/app_colors.dart';
import 'package:earning/controller/payment_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/jumping_dots/jumping_dots.dart';
import 'package:earning/view/widget/loading/image_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey webViewKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PaymentController>(
        init: PaymentController(),
        builder: (logic) {
          return PopScope(
            canPop: false,
            onPopInvoked: (value) async {
                if(mounted){
                  showDialog(
                      context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text("payment_cancel".tr),
                          content: Text("do_you_want_to_skip_verification".tr),
                          actions: [
                            TextButton(onPressed: (){
                              Get.offAllNamed(AppRoute.navScreen);
                            }, child: Text("yes".tr)),
                            TextButton(onPressed: (){
                              Get.back();
                            }, child: Text("no".tr)),
                          ],
                        );
                      },
                  );
                }
            },
            child: Scaffold(
                body: Stack(
                  children: [
                    logic.isLoading?const Center(child: ImageLoading()):
                    logic.isError? Center(child: Text("now_verification_is_closed".tr),):
                    InAppWebView(
                      key: webViewKey,
                      onWebViewCreated: logic.isWebViewCreatedFunction,
                      onLoadStop: logic.onWebviewLoadStop,
                      onReceivedError: logic.onWebViewReceiveError,
                      onProgressChanged: logic.onWebViewProgressChange,
                      onUpdateVisitedHistory: logic.onUpdateVisitedHistory,
                      initialSettings: InAppWebViewSettings(
                        disableDefaultErrorPage: true,
                        cacheEnabled: true,
                        javaScriptEnabled: true,
                        useOnLoadResource: true,
                      ),
                      initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(logic.paymentUrl??""))),
                    ),
                    if(logic.isPaymentLoading)
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.width/2,
                          width: MediaQuery.of(context).size.width/2,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.blackColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("please_wait_verification_progress".tr,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16,color: AppColors.whiteColor),),
                              const SizedBox(height: 20,),
                              JumpingDots(
                                color: Colors.orangeAccent,
                                radius: 12,
                                numberOfDots: 3,
                              )
                            ],
                          ),
                        ),
                      ),
                    if(logic.isWebLoading)
                      const Center(child: ImageLoading()),
                  ],
                ),
            ),
          );
        }
      ),
    );
  }
}
