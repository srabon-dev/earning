import 'package:earning/constant/app_colors.dart';
import 'package:earning/controller/home_controller.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/model/post_model.dart';
import 'package:earning/view/screen/home/widget/drawer_widget.dart';
import 'package:earning/view/widget/button/custom_button.dart';
import 'package:earning/view/widget/loading/image_loading.dart';
import 'package:earning/view/widget/post/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';
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
  void initState() {
    super.initState();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    print('checking for Update');
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        if (info.updateAvailability == UpdateAvailability.updateAvailable) {
          print('update available');
          update();
        }else{
          print('update Not available');
        }
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void update() async {
    await InAppUpdate.performImmediateUpdate().then((_) {}).catchError((e) {
      print(e.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (logic) {
          return Scaffold(
            key: scaffoldKey,
            appBar: HomeAppBar(scaffoldKey: scaffoldKey),
            drawer: const HomeDrawer(),
            body: logic.isPostLoading?const Center(child: ImageLoading()): SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              child: Column(
                children: [
                  const HomeCreatePost(),
                  const SizedBox(height: 8.0),
                  logic.isLoading?const SizedBox():(logic.userModel.isVerified??false)?const SizedBox():Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: Text("your_account_not_verified".tr,maxLines: 3,style: const TextStyle(color: AppColors.redColor),),
                      ),
                      const SizedBox(height: 8.0),
                      CustomButton(text: "Verify Account", onTap: (){
                        Get.toNamed(AppRoute.verifyScreen);
                      }),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  logic.error?Center(child: Text("no_posts_available".tr)):ListView.separated(
                    itemCount: logic.data?.length??0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox();
                    },
                    itemBuilder: (BuildContext context, int index){
                      PostModel postModel = PostModel(
                        desc: logic.data?[index]['desc'],
                        email: logic.data?[index]['email'],
                        id: logic.data?[index]['id'],
                        uid: logic.data?[index]['uid'],
                        name: logic.data?[index]['name'],
                        isApproved: logic.data?[index]['isApproved'],
                        postImage: logic.data?[index]['postImage'],
                        createdAt: logic.data?[index]['createdAt'],
                        profileImage: logic.data?[index]['profileImage'],
                      );
                      return PostCard(postModel: postModel, userModel: logic.userModel,);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
