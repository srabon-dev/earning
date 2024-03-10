import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/message_controller.dart';
import 'package:earning/model/message_model.dart';
import 'package:earning/view/screen/message/widget/chat_appbar.dart';
import 'package:earning/view/screen/message/widget/chat_bubble.dart';
import 'package:earning/view/screen/message/widget/image_chat_bubble.dart';
import 'package:earning/view/widget/loading/card_loading.dart';
import 'package:earning/view/widget/loading/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/chat_input_field.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController? scrollController;
  @override
  void initState() {
    super.initState();
    Get.put(MessageController());
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const ChatAppBar(),
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage(AppImages.chat), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('message').doc(FirebaseAuth.instance.currentUser?.uid).collection('chat').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                    if (snapshot.hasError) {
                      return Center(child: Text("something_went_wrong".tr));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ListView.builder(
                        itemCount: 5,
                        itemBuilder: (BuildContext context, int index){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomLoading(height: 80, width: MediaQuery.of(context).size.width),
                          );
                        },
                      );
                    }
                    if(snapshot.data?.docs.isEmpty??false){
                      return Center(child: Text("no_message_available".tr));
                    }else if(snapshot.data?.docs.isNotEmpty??false){
                      WidgetsBinding.instance?.addPostFrameCallback((_) {
                        scrollController?.animateTo(
                          scrollController!.position.extentTotal+500,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      });
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5.0),
                        itemCount: snapshot.data?.docs.length,
                        controller: scrollController,
                        itemBuilder: (BuildContext context, int index){
                          MessageModel massageModel = MessageModel(
                            id: snapshot.data?.docs[index]['id'],
                            uid: snapshot.data?.docs[index]['uid'],
                            email: snapshot.data?.docs[index]['email'],
                            name: snapshot.data?.docs[index]['name'],
                            image: snapshot.data?.docs[index]['image'],
                            postImage: snapshot.data?.docs[index]['postImage'],
                            message: snapshot.data?.docs[index]['message'],
                            receive: snapshot.data?.docs[index]['receive'],
                            isMe: snapshot.data?.docs[index]['isMe'],
                            isImage: snapshot.data?.docs[index]['isImage'],
                            createdAt: snapshot.data?.docs[index]['createdAt'],
                          );
                          if(massageModel.isImage??false){
                            return ImageChatBubble(messageModel: massageModel);
                          }else{
                            return ChatBubble(messageModel: massageModel);
                          }
                        },
                      );
                    }else{
                      return Center(child: Text("no_message_available".tr));
                    }
                  },
                ),
              ),
              ChatInputField(scrollController: scrollController),
            ],
          ),
        ),
      ),
    );
  }
}
