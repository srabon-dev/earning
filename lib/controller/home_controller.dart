import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  bool error = false;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;

  bool isLoading = false;
  Future<void> getUserDetails() async {
    isLoading = true;
    update();
    try {
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).snapshots().listen((event) {
        userModel = UserModel.fromJson(event.data() ?? {});
        update();
        isLoading = false;
        update();
      });
    } catch (error) {
      isLoading = false;
      update();
    }
  }
  bool isPostLoading = false;
  Future<void> getPost() async {
    try{
      isPostLoading = true;
      update();
      await firestore.collection('post').orderBy("createdAt",descending: true).where('isApproved',isEqualTo: true).get().then((value){
        if(value.docs.isEmpty){
          error = true;
          update();
          isPostLoading = false;
          update();
        }else if(value.docs.isNotEmpty){
          data = value.docs;
          update();
          isPostLoading = false;
          update();
        }else{
          error = true;
          update();
          isPostLoading = false;
          update();
        }
      }).onError((error, stackTrace){
        isPostLoading = false;
        update();
        log(error.toString());
      });
    }catch(error){
      isPostLoading = false;
      update();
      log(error.toString());
    }
  }

  @override
  void onInit() {
    Future.wait([
      getPost(),
    getUserDetails(),
    ]);
    print("object");
    super.onInit();
  }
}