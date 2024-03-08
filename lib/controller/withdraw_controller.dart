import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class WithdrawController extends GetxController{

  int selectedValue = 1;
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel();

  void changeSelectedValue(int? newValue){
    selectedValue = newValue??0;
    update();
  }

  bool isLoading = false;
  Future<void> sendWithdrawRequest() async {
    try {
      isLoading = true;
      update();
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).get().then((value) async {
        userModel = UserModel.fromJson(value.data() ?? {});
        update();
        if((userModel.balance??0.0) >= 1000.0){
          if(await InternetConnectionChecker().hasConnection){
            final double newBalance = userModel.balance! - double.parse('${amountController.text.trim()}.0');
            firestore.collection('user').doc(firebaseAuth.currentUser?.uid).update({
              'balance': newBalance,
            }).then((value){
              final String docId = '${firebaseAuth.currentUser?.uid}${DateTime.now().microsecondsSinceEpoch}';
              final String provider = selectedValue == 1? "Bkash": "Nagad";
              firestore.collection('withdraw').doc(docId).set({
                'id': docId,
                'email': firebaseAuth.currentUser?.email,
                'provider': provider,
                'status': "Pending",
                'createdAt': FieldValue.serverTimestamp(),
                'amount': amountController.text.trim(),
                'phone': numberController.text.trim(),
                'name': nameController.text,
              }).then((value){
                isLoading = false;
                update();
                Fluttertoast.showToast(msg: "Successful Send Withdraw Request");
              }).onError((error, stackTrace){
                isLoading = false;
                update();
                Fluttertoast.showToast(msg: error.toString());
              });
            }).onError((error, stackTrace){
              log(error.toString());
              isLoading = false;
              update();
            });
          }else{
            Fluttertoast.showToast(msg: "Please check your internet connection!");
            isLoading = false;
            update();
          }
        }else{
          Fluttertoast.showToast(msg: "Your coins is low, minimum withdrawal 1000 coins");
          isLoading = false;
          update();
        }
      }).onError((error, stackTrace) {
        log(error.toString());
        isLoading = false;
        update();
      }).timeout(const Duration(seconds: 10));
    } catch (error) {
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: error.toString());
    }
  }
}