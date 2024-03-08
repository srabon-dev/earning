import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MessageController extends GetxController{
  TextEditingController messageController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  UserModel userModel = UserModel();
  File? image;
  String? imageURL;
  bool isFileLoading = false;
  bool isLoading = false;


  Future<void> getUserDetails() async {
    try {
      await firestore.collection('user').doc(firebaseAuth.currentUser?.uid).get().then((value) async {
        userModel = UserModel.fromJson(value.data() ?? {});
        update();
      }).onError((error, stackTrace) {
        log(error.toString());
      }).timeout(const Duration(seconds: 10));
    } catch (error) {
      log(error.toString());
    }
  }

  void openPhotoGallery() async{
    try{
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(pickedFile != null){
        image = File(pickedFile.path);
        update();
      }
    }catch(error){
      Get.snackbar("Error", "Image Pick Error");
    }
  }

  void removeImage(){
    image = null;
    update();
  }

  Future<void> sendMessage() async{
    isLoading = true;
    update();
    try{
      final String docId = '${firebaseAuth.currentUser?.uid}${DateTime.now().microsecondsSinceEpoch}';
      firestore.collection('message').doc(firebaseAuth.currentUser?.uid).collection('chat').doc(docId).set({
        'id': docId,
        'uid': firebaseAuth.currentUser?.uid,
        'email': firebaseAuth.currentUser?.email,
        'name' : userModel.name,
        'isMe' : true,
        'isImage': false,
        'postImage' : "",
        'image' : userModel.image,
        'message' : messageController.text,
        'receive': 'opex',
        'createdAt': FieldValue.serverTimestamp(),
      }).then((value){
        isLoading = false;
        update();
        messageController.text = "";
        update();
      }).onError((error, stackTrace){
        log(error.toString());
        Fluttertoast.showToast(msg: "Message Send failed");
        isLoading = false;
        update();
      });
    }catch(error){
      log(error.toString());
      Fluttertoast.showToast(msg: "Message Send failed");
      isLoading = false;
      update();
    }
  }

  Future<void> sendImage() async{
    isFileLoading = true;
    update();
    try{
      if(image != null){
        Reference refBox = storage.ref().child("message/${firebaseAuth.currentUser?.uid}/${DateTime.now().microsecondsSinceEpoch}${image?.path.split('/').last}");
        refBox.putFile(image!).whenComplete(() async {
          imageURL = await refBox.getDownloadURL();
          update();
          final String docId = '${firebaseAuth.currentUser?.uid}${DateTime.now().microsecondsSinceEpoch}';
          firestore.collection('message').doc(firebaseAuth.currentUser?.uid).collection('chat').doc(docId).set({
            'id': docId,
            'uid': firebaseAuth.currentUser?.uid,
            'email': firebaseAuth.currentUser?.email,
            'name' : userModel.name,
            'isMe' : true,
            'isImage': true,
            'postImage' : imageURL,
            'image' : userModel.image,
            'message' : messageController.text,
            'receive': 'opex',
            'createdAt': FieldValue.serverTimestamp(),
          }).then((value){
            isFileLoading = false;
            update();
            image = null;
            update();
          }).onError((error, stackTrace){
            log(error.toString());
            Fluttertoast.showToast(msg: "Image Send failed");
            isFileLoading = false;
            update();
          });
        });
      }
    }catch(error){
      log(error.toString());
      Fluttertoast.showToast(msg: "Image Send failed");
      isFileLoading = false;
      update();
    }
  }
  
  @override
  void onReady() {
    getUserDetails();
    super.onReady();
  }
}