import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailRController = TextEditingController();
  TextEditingController passwordRController = TextEditingController();
  TextEditingController confirmPasswordRController = TextEditingController();
  TextEditingController phoneController = TextEditingController();


  TextEditingController resetEmailController = TextEditingController();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isLoading = false;

  //this function call Email And Password login in user this app
  Future<void> login() async {
    isLoading = true;
    update();
    try {
      await firebaseAuth
          .signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      )
          .then((value) {
        if (value.user?.uid != null) {
          isLoading = false;
          update();
          Fluttertoast.showToast(msg: "Login Successful");
          Get.offAndToNamed(AppRoute.navScreen);
        } else {
          isLoading = false;
          update();
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      }).onError((error, stackTrace) {
        isLoading = false;
        update();
        Fluttertoast.showToast(msg: "$error");
      });
      isLoading = false;
      update();
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: error.message ?? "Something went wrong");
    }
  }

  //this function call Email And Password Register in user this app
  Future<void> register() async {
    isLoading = true;
    update();
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: emailRController.text.trim(),
        password: passwordRController.text.trim(),
      )
          .then((value) {
        if (value.user?.uid != null) {
          firestore.collection('user').doc(value.user?.uid).set({
            'name': nameController.text,
            'phone': phoneController.text,
            'email': emailRController.text.trim()
          }).then((value) {
            isLoading = false;
            update();
            Fluttertoast.showToast(msg: "Account Create Successful");
            Get.offAndToNamed(AppRoute.navScreen);
          }).onError((error, stackTrace) {
            isLoading = false;
            update();
            Fluttertoast.showToast(msg: "Something went wrong");
          });
        } else {
          isLoading = false;
          update();
          Fluttertoast.showToast(msg: "Something went wrong");
        }
      }).onError((error, stackTrace) {
        isLoading = false;
        update();
        Fluttertoast.showToast(msg: "$error");
      });
      isLoading = false;
      update();
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: error.message ?? "Something went wrong");
    }
  }

  //this function call Email And Password Forget in user this app
  Future<void> forget() async {
    isLoading = true;
    update();
    try {
      await firebaseAuth.sendPasswordResetEmail(email: resetEmailController.text.trim()).then((value) {
        isLoading = false;
        update();
        Fluttertoast.showToast(msg: "Forget password link send successful, please check your email address");
        Get.offAndToNamed(AppRoute.navScreen);
      }).onError((error, stackTrace) {
        isLoading = false;
        update();
        Fluttertoast.showToast(msg: "$error");
      });
      isLoading = false;
      update();
    } on FirebaseAuthException catch (error) {
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: error.message ?? "Something went wrong");
    }
  }
}