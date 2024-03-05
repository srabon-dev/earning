import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/model/user_model.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? imagePhotoFile;
  String imageURL = '';
  UserModel userModel = UserModel();

  bool isLoading = false;
  Future<void> getUserDetails() async {
    isLoading = true;
    update();
    try {
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).get().then((value) async {
        userModel = UserModel.fromJson(value.data() ?? {});
        update();
        nameController = TextEditingController(text: userModel.name);
        phoneController = TextEditingController(text: userModel.phone);
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

  void openPhotoGallery() async{
    try{
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(pickedFile != null){
        imagePhotoFile = File(pickedFile.path);
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
        imagePhotoFile = File(pickedFile.path);
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

  bool updateLoading = false;
  Future<void> updateProfile() async{
    try{
      updateLoading = true;
      update();
      if(imagePhotoFile != null){
        Reference refBox = storage.ref().child("profile/${firebaseAuth.currentUser?.uid}/${DateTime.now().microsecondsSinceEpoch}${imagePhotoFile?.path.split('/').last}");
        refBox.putFile(imagePhotoFile!).whenComplete(() async {
          imageURL = await refBox.getDownloadURL();
          update();
          await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).update({
            'name': nameController.text,
            'phone': phoneController.text,
            'image': imageURL
          }).then((value){
            updateLoading = false;
            update();
            Fluttertoast.showToast(msg: "Successful Update");
            getUserDetails();
          }).onError((error, stackTrace){
            log("Error By Firestore ${error.toString()}");
            updateLoading = false;
            update();
          }).timeout(const Duration(seconds: 10));
        });
      }else{
        await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).update({
          'name': nameController.text,
          'phone': phoneController.text,
        }).then((value){
          updateLoading = false;
          update();
          Fluttertoast.showToast(msg: "Successful Update");
          getUserDetails();
        }).onError((error, stackTrace){
          log(error.toString());
          updateLoading = false;
          update();
        }).timeout(const Duration(seconds: 10));
      }
    }catch(error){
      log(error.toString());
      updateLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    getUserDetails();
    super.onInit();
  }
}
