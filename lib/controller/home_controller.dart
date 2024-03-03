import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class HomeController extends GetxController{
  VideoPlayerController? videoPlayerController;
  PageController pageController = PageController(initialPage: 0, viewportFraction: 1);
  bool isPlayVideo = true;
  bool isVisible = false;

  List<String> url = [
    'https://firebasestorage.googleapis.com/v0/b/earning-5ed58.appspot.com/o/ssstik.io_1709243805693.mp4?alt=media&token=aae70aab-0c50-493f-9231-ae7cd042a9ed',
    'https://firebasestorage.googleapis.com/v0/b/earning-5ed58.appspot.com/o/ssstik.io_1709287161536.mp4?alt=media&token=4e539655-330f-4cc9-9060-9106531d9e11',
    'https://firebasestorage.googleapis.com/v0/b/earning-5ed58.appspot.com/o/ssstik.io_1709264333182.mp4?alt=media&token=948eb4ce-53e4-4282-9e72-ae9129badb44',
  ];

  void initVideoPlayer({required String url}) async{
    try{
      videoPlayerController?.dispose();
      videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((value) {
          videoPlayerController?.play();
          videoPlayerController?.setVolume(1);
          isVisibleControl();
        }).onError((error, stackTrace){
          Fluttertoast.showToast(msg: "Video Play Error");
        });
      update();
    }catch(error){
      Fluttertoast.showToast(msg: "Video Play Error");
    }
  }

  void videoPlayControl(){
    isVisibleControl();
    try{
      if(isPlayVideo){
        videoPlayerController?.pause();
        isPlayVideo = false;
        update();
      }else{
        videoPlayerController?.play();
        isPlayVideo = true;
        update();
      }
    }catch(error){
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  void isVisibleControl(){
    try{
      isVisible = true;
      update();
      Future.delayed(const Duration(seconds: 1),(){
        isVisible = false;
        update();
      });
    }catch(error){
      log("Play Button Visible Error");
    }
  }


  @override
  void onInit() {
    super.onInit();
    initVideoPlayer(url: url[0]);
  }

  @override
  void onClose() {
    super.onClose();
    videoPlayerController?.dispose();
  }
}