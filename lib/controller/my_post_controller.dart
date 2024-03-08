import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class MyPostController extends GetxController{

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UserModel userModel = UserModel();

  bool isLoading = false;
  Future<void> getUserDetails() async {
    isLoading = true;
    update();
    try {
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).get().then((value) async {
        userModel = UserModel.fromJson(value.data() ?? {});
        isLoading = false;
        update();
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(msg: error.toString());
        isLoading = false;
        update();
      }).timeout(const Duration(seconds: 10));
    } catch (error) {
      isLoading = false;
      update();
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}