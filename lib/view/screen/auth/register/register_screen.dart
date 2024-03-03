import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/auth_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/text_field/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                    //Logo--------------------------
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: Image.asset(AppImages.logo),
                    ),

                    //Name TextField -----------------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Name",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 8,),
                    CustomTextField(hintText: "Enter Name",  validator: (name){
                      if(logic.nameController.text == ""){
                        return "Please enter valid name";
                      }else{
                        return null;
                      }
                    } , controller: logic.nameController, prefixIcon: Iconsax.profile_circle,),
                    const SizedBox(height: 5),

                    //Email TextField ---------------------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Email",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 5),
                    CustomTextField(hintText: "Enter Email", validator: (email){
                      final bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
                      if(emailValid){
                        return null;
                      }else{
                        return "Please Enter Valid Email Address";
                      }
                    } ,controller: logic.emailRController, prefixIcon: Icons.email_outlined,),
                    const SizedBox(height: 12),

                    //Phone TextField ----------------------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Phone Number",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 5),
                    CustomTextField(hintText: "Enter Number", validator: (phone){
                      if(logic.phoneController.text == ""){
                        return "Please enter valid Phone Number";
                      }else{
                        return null;
                      }
                    } , controller: logic.phoneController,prefixIcon: Iconsax.call,),
                    const SizedBox(height: 12),

                    //Password TextField -------------------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Password",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 5),
                    CustomTextField(hintText: "Enter Password",  validator: (password){
                      if(logic.passwordRController.text == ""){
                        return "Please Enter Valid Password";
                      }else if(logic.passwordRController.text.length < 6){
                        return "Password must be 6 characters";
                      }else{
                        return null;
                      }
                    } ,controller: logic.passwordRController, isPassword: true, prefixIcon: Iconsax.lock,),
                    const SizedBox(height: 12),

                    //Confirm Password TextField ------------------------
                    Align(alignment: Alignment.centerLeft,child: Text("Confirm Password",style: Theme.of(context).textTheme.titleLarge,)),
                    const SizedBox(height: 5),
                    CustomTextField(hintText: "Confirm Password",  validator: (conPassword){
                      if(logic.confirmPasswordRController == logic.passwordRController.text){
                        return "Password do NOT match";
                      }else{
                        return null;
                      }
                    } ,controller: logic.confirmPasswordRController, isPassword: true, prefixIcon: Iconsax.lock,),
                    const SizedBox(height: 24),
                    logic.isLoading?const Center(child: CircularProgressIndicator(),) : CustomButton(text: "Create Account", onTap: (){
                      if(formKey.currentState!.validate()){
                        logic.register();
                      }
                    }),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(AppRoute.loginScreen);
                          },
                          child: Text(" Login",style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
