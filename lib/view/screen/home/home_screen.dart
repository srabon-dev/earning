import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/controller/home_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/model/post_model.dart';
import 'package:earning/view/screen/home/widget/drawer_widget.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/loading/card_loading.dart';
import 'package:earning/view/widget/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widget/home_app_bar.dart';
import 'widget/home_create_post.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (logic) {
          print("Chaking ${logic.userModel.isVerified}");
          return Scaffold(
            key: scaffoldKey,
            appBar: HomeAppBar(scaffoldKey: scaffoldKey),
            drawer: const HomeDrawer(),
            body:SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              child: Column(
                children: [
                  const HomeCreatePost(),
                  const SizedBox(height: 8.0),
                  logic.isLoading?const SizedBox():(logic.userModel.isVerified??false)?const SizedBox(): logic.userModel.verificationStatus=="Pending"?Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: const Text("Your verification status is pending. Our skilled support team will verify your information and verify your account. stay with us Thank you",maxLines: 3,style: TextStyle(color: AppColors.redColor),),
                      ),
                      const SizedBox(height: 8.0),
                      CustomButton(text: "Re Verification", onTap: (){
                        Get.toNamed(AppRoute.verifyScreen);
                      }),
                    ],
                  ):logic.userModel.verificationStatus=="Active"?const SizedBox():Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: const Text("Your account is not verified, please verify account and start earning",maxLines: 3,style: TextStyle(color: AppColors.redColor),),
                      ),
                      const SizedBox(height: 8.0),
                      CustomButton(text: "Verify Account", onTap: (){
                        Get.toNamed(AppRoute.verifyScreen);
                      }),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('post').orderBy("createdAt",descending: true).where('isApproved',isEqualTo: true).snapshots(),
                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: Text("Something went wrong"));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ListView.builder(
                            itemCount: 5,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index){
                              return const CardLoading();
                            },
                          );
                        }
                        if(snapshot.data?.docs.isEmpty??false){
                          return const Center(child: Text("No posts available"));
                        }else if(snapshot.data?.docs.isNotEmpty??false){
                          return ListView.separated(
                            itemCount: snapshot.data?.docs.length??0,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox();
                            },
                            itemBuilder: (BuildContext context, int index){
                              PostModel postModel = PostModel(
                                  desc: snapshot.data?.docs[index]['desc'],
                                  email: snapshot.data?.docs[index]['email'],
                                  id: snapshot.data?.docs[index]['id'],
                                  uid: snapshot.data?.docs[index]['uid'],
                                  name: snapshot.data?.docs[index]['name'],
                                  isApproved: snapshot.data?.docs[index]['isApproved'],
                                  postImage: snapshot.data?.docs[index]['postImage'],
                                  createdAt: snapshot.data?.docs[index]['createdAt'],
                                  profileImage: snapshot.data?.docs[index]['profileImage'],
                              );
                              return PostCard(postModel: postModel, userModel: logic.userModel,);
                            },
                          );
                        }else{
                          return const Center(child: Text("No posts available"));
                        }
                      }
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
