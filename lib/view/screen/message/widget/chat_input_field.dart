import 'package:earning/constant/app_colors.dart';
import 'package:earning/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({super.key, required this.scrollController});
  final ScrollController? scrollController;
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GetBuilder<MessageController>(
      builder: (logic) {
        return logic.image != null?Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/3-50,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(logic.image!,fit: BoxFit.contain,)),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(onPressed: () {
                        logic.removeImage();
                      }, icon: const Icon(Icons.cancel,color: Colors.black,size: 32,),),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: logic.messageController,
                        minLines: 1,
                        maxLines: 2,
                        maxLength: 1000,
                        style: const TextStyle(
                            color: AppColors.blackColor
                        ),
                        decoration: InputDecoration(
                          hintStyle: const TextStyle(
                              color: AppColors.blackColor
                          ),
                          counterText: "",
                          suffixIcon: GestureDetector(
                            onTap: (){
                              logic.openPhotoGallery();
                            },
                            child: const Padding(
                              padding: EdgeInsetsDirectional.only(start: 10, top: 6, bottom: 6, end: 6),
                              child: Icon(Iconsax.gallery,size: 28,color: AppColors.blackColor,),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.blackColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.blackColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: AppColors.blackColor),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.redColor),
                          ),
                          hintText: "Write your message",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: logic.isFileLoading? const Center(child: CircularProgressIndicator(),): GestureDetector(
                        onTap: () {
                          logic.sendImage();
                          scrollController?.animateTo(
                            scrollController?.position.maxScrollExtent??0+100,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: const Icon(Icons.send,color: AppColors.blackColor),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ):Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 20, right: 20,top: 5),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: logic.messageController,
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 1000,
                  style: const TextStyle(
                    color: AppColors.blackColor
                  ),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        color: AppColors.blackColor
                    ),
                    counterText: "",
                    suffixIcon: GestureDetector(
                      onTap: (){
                        logic.openPhotoGallery();
                      },
                      child: const Padding(
                        padding: EdgeInsetsDirectional.only(start: 10, top: 6, bottom: 6, end: 6),
                        child: Icon(Iconsax.gallery,size: 28,color: AppColors.blackColor,),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.blackColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.blackColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: AppColors.blackColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.redColor),
                    ),
                    hintText: "Write your message",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: logic.isLoading? const Center(child: CircularProgressIndicator(),): GestureDetector(
                  onTap: () {
                    if(logic.messageController.text != ""){
                      logic.sendMessage();
                      scrollController?.animateTo(
                        scrollController?.position.maxScrollExtent??0+100,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }else{
                      Fluttertoast.showToast(msg: "Please write a message!");
                    }
                  },
                  child: const Icon(Icons.send,color: AppColors.blackColor),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}