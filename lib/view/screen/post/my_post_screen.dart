import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/controller/my_post_controller.dart';
import 'package:earning/model/post_model.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/loading/card_loading.dart';
import 'package:earning/view/widget/post/post_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPostScreen extends StatelessWidget {
  const MyPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<MyPostController>(
        init: MyPostController(),
        builder: (logic) {
          return Scaffold(
            appBar: CustomAppBar(name: "my_post".tr),
            body: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('post').orderBy("createdAt",descending: true).where('email',isEqualTo: FirebaseAuth.instance.currentUser?.email).snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('something_went_wrong'.tr));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (BuildContext context, int index){
                        return const CardLoading();
                      },
                    );
                  }
                  if(snapshot.data?.docs.isEmpty??false){
                    return Center(child: Text("no_posts_available".tr));
                  }else if(snapshot.data?.docs.isNotEmpty??false){
                    return ListView.separated(
                      itemCount: snapshot.data?.docs.length??0,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        PostModel postModel = PostModel(
                            desc: snapshot.data?.docs[index]['desc'],
                            email: snapshot.data?.docs[index]['email'],
                            id: snapshot.data?.docs[index]['id'],
                            uid: snapshot.data?.docs[index]['uid'],
                            name: snapshot.data?.docs[index]['name'],
                            isApproved: snapshot.data?.docs[index]['isApproved'],
                            postImage: snapshot.data?.docs[index]['postImage'],
                            createdAt: snapshot.data?.docs[index]['createdAt'],
                            profileImage: snapshot.data?.docs[index]['profileImage']
                        );
                        return PostCard(isMyPost: true,postModel: postModel,userModel: logic.userModel);
                      },
                    );
                  }else{
                    return Center(child: Text("no_posts_available".tr));
                  }
                }
              ),
            ),
          );
        }
      ),
    );
  }
}
