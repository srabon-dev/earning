import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/auth_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
        init: AuthController(),
        builder: (logic) {
          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(name: "forget_password".tr,isBack: true),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.asset(AppImages.logo),
                      ),
                      Align(alignment: Alignment.centerLeft,child: Text("email".tr,style: Theme.of(context).textTheme.titleLarge,)),
                      const SizedBox(height: 5),
                      CustomTextField(hintText: "enter_email".tr, validator: (email){
                        final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                        if(emailValid){
                          return null;
                        }else{
                          return "please_enter_valid_email_address".tr;
                        }
                      } ,controller: logic.resetEmailController, prefixIcon: Icons.email_outlined,),
                      const SizedBox(height: 24),
                      logic.isLoading?const Center(child: CircularProgressIndicator(),) : CustomButton(text: "confirm".tr, onTap: (){
                        if(formKey.currentState!.validate()){
                          logic.forget();
                        }
                      }),
                      const SizedBox(height: 24),

                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}
