import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/auth_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (logic) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    //Logo Section ------------------------
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                        height: 250,
                        child: Image.asset(AppImages.logo),
                    ),

                    //Email TextField -----------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Email",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 5),
                    CustomTextField(hintText: "Enter Email", validator: (email){
                      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if(emailValid){
                        return null;
                      }else{
                        return "Please Enter Valid Email Address";
                      }
                    } , controller: logic.emailController, prefixIcon: Icons.email_outlined,),
                    const SizedBox(height: 12),

                    //Password TextField ------------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Password",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 5),
                    CustomTextField(hintText: "Enter Password", validator: (password){
                      if(password == null && password == ""){
                        return "Please Enter Valid Password";
                      }else if(password.length < 5){
                        return "Password must be 6 characters";
                      }else{
                        return null;
                      }
                    } , controller: logic.passwordController, isPassword: true, prefixIcon: Iconsax.lock,),
                    const SizedBox(height: 5,),

                    //Forget Password -----------------------
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(AppRoute.forgetPassword);
                      },
                      child: const Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forget Password?",style: TextStyle(color: AppColors.greenColor),),
                      ),
                    ),
                    const SizedBox(height: 24),

                    //Login Button ---------------------------
                    logic.isLoading?Center(child: CircularProgressIndicator(),) : CustomButton(text: "Login", onTap: (){
                      if(formKey.currentState!.validate()){
                        logic.login();
                      }
                    }),
                    const SizedBox(height: 24),

                    //Navigate Register Screen ------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Don't have an Account?"),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.registerScreen);
                          },
                          child: Text(" Register",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.greenColor,
                          ),),
                        )
                      ],
                    ),

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