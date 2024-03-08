import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/model/user_model.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostController extends GetxController{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  TextEditingController descriptionController = TextEditingController();
  UserModel userModel = UserModel();
  File? postImage;
  String imageURL = '';
  int? todayPost = 0;


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
        isLoading = false;
        update();
      }).timeout(const Duration(seconds: 10));
    } catch (error) {
      isLoading = false;
      update();
    }
  }

  void openPhotoGallery() async{
    try{
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedFile != null){
        postImage = File(pickedFile.path);
        update();
        Get.back();
      }
    }catch(error){
      Get.snackbar("Error", "Image Pick Error");
    }
  }

  void openPhotoCamera() async{
    try{
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if(pickedFile != null){
        postImage = File(pickedFile.path);
        update();
        Get.back();
      }
    }catch(error){
      Get.snackbar("Error", "Image Pick Error");
    }
  }

  void showCameraPickDialog(BuildContext context){
    showDialog(context: context, builder: (context){
      return Dialog(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height/6,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.blackColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(text: "Open Camera", onTap: ()=>openPhotoCamera()),
              const SizedBox(height: 8.0,),
              CustomButton(text: "Open Gallery", onTap: ()=>openPhotoGallery()),
            ],
          ),
        ),
      );
    });
  }

  Future<void> getPostLimit() async{
    try{
      DateTime now = DateTime.now();
      DateTime startOfToday = DateTime(now.year, now.month, now.day);
      DateTime endOfToday = DateTime(now.year, now.month, now.day, 23, 59, 59, 999);
      await firestore.collection('post')
          .where('email', isEqualTo: firebaseAuth.currentUser?.email)
          .where('createdAt', isGreaterThanOrEqualTo: startOfToday)
          .where('createdAt', isLessThanOrEqualTo: endOfToday)
          .get().then((value){
            todayPost = value.docs.length;
            update();
      }).onError((error, stackTrace){
        log(error.toString());
      });
    }catch(error){
      log(error.toString());
    }
  }

  bool updateLoading = false;
  Future<void> post() async{
    try{
      updateLoading = true;
      update();
      if(userModel.isVerified??false){
        if(postImage != null){
          Reference refBox = storage.ref().child("post/${firebaseAuth.currentUser?.uid}/${DateTime.now().microsecondsSinceEpoch}${postImage?.path.split('/').last}");
          refBox.putFile(postImage!).whenComplete(() async {
            imageURL = await refBox.getDownloadURL();
            update();
            final String docId = '${firebaseAuth.currentUser?.uid}${DateTime.now().microsecondsSinceEpoch}';
            firestore.collection('post').doc(docId).set({
              'id': docId,
              'email': firebaseAuth.currentUser?.email,
              'uid': firebaseAuth.currentUser?.uid,
              'name': userModel.name,
              'isApproved': false,
              'profileImage': userModel.image,
              'desc': descriptionController.text,
              'postImage': imageURL,
              'createdAt': FieldValue.serverTimestamp(),
            }).then((value){
              updateLoading = false;
              update();
              Fluttertoast.showToast(msg: "Post Successful");
              Get.offAndToNamed(AppRoute.navScreen);
            }).onError((error, stackTrace){
              log("Error By Firestore ${error.toString()}");
              updateLoading = false;
              update();
            }).timeout(const Duration(seconds: 10));
          });
        }else{
          Fluttertoast.showToast(msg: "Please upload image");
        }
      }else{
        Fluttertoast.showToast(msg: "you are not verified person Please first verify your account!");
        Get.offAndToNamed(AppRoute.verifyScreen);
      }
    }catch(error){
      Fluttertoast.showToast(msg: "Post Unsuccessful");
    }
  }

  @override
  void onInit() {
    getUserDetails();
    getPostLimit();
    super.onInit();
  }
}