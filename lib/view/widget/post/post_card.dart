import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/model/post_model.dart';
import 'package:earning/view/widget/loading/custom_loading.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:like_button/like_button.dart';
import 'package:readmore/readmore.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key, this.isMyPost = false, this.postModel});
  final bool isMyPost;
  final PostModel? postModel;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool like = false;
  @override
  void initState() {
    getLikeFunction();
    super.initState();
  }

  void getLikeFunction() async{
    like = await getLike();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor)),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isDarkMode ? AppColors.blackColor:AppColors.whiteColor,
          ),
          child: Column(
            children: [

              //Top Section
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: widget.postModel?.profileImage != '' && widget.postModel?.profileImage != null? CachedNetworkImage(
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    const CustomLoading(width: 40, height: 40),
                                errorWidget: (context, url, error) =>
                                const Icon(Iconsax.profile_circle,size: 35,),
                                imageUrl:widget.postModel!.profileImage!):Image.asset(AppImages.profile,fit: BoxFit.cover,),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.postModel?.name??"",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 5),
                        const Icon(Iconsax.verify,size: 18,color: AppColors.greenColor,),
                      ],
                    ),
                    Row(
                      children: [
                        widget.isMyPost?Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isDarkMode? AppColors.whiteColor.withOpacity(0.4): AppColors.blackColor.withOpacity(0.1),
                          ),
                          child: Center(child: widget.postModel?.isApproved?? false?const Text("Active",style: TextStyle(color: AppColors.greenColor),):const Text("Pending",style: TextStyle(color: AppColors.redColor),),),
                        ):const SizedBox(),
                        PopupMenuButton<String>(
                          onSelected: (String choice){
                            if(choice == "Edit"){
                              Get.toNamed(AppRoute.editPostScreen, arguments: widget.postModel?.id);
                            }
                          },
                          itemBuilder: (BuildContext context)=>[
                            PopupMenuItem<String>(
                                value: widget.postModel?.email == FirebaseAuth.instance.currentUser?.email?"Edit":"Report",
                                child: ListTile(
                                  title: Text(widget.postModel?.email == FirebaseAuth.instance.currentUser?.email?"Edit":"Report"),
                                  leading: Icon(widget.postModel?.email == FirebaseAuth.instance.currentUser?.email?Iconsax.edit:Iconsax.receipt),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Text Section
              ListTile(
                title: ReadMoreText( widget.postModel?.desc??"",
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: ' Show more',
                  trimExpandedText: ' Show less',
                  moreStyle: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800).copyWith(
                      color: isDarkMode ? AppColors.whiteColor : AppColors.blackColor
                  ),
                  lessStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppColors.redColor,
                  ),
                ),
              ),

              //Image Section
              GestureDetector(
                onTap: (){
                  showImageViewer(context, Image.network(widget.postModel?.postImage??"").image,
                      swipeDismissible: true);
                },
                child: SizedBox(
                  width: width,
                  height: height / 5,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        CustomLoading(width: width, height: height / 5),
                    errorWidget: (context, url, error) =>
                    const Icon(Iconsax.gallery,size: 35,),
                    imageUrl: widget.postModel?.postImage??"",
                  ),
                ),
              ),
              const SizedBox(height: 8.0),


              //Live Button Section
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('post').doc(widget.postModel?.id??"").collection('like').where('like',isEqualTo: true).snapshots(),
                builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if (snapshot.hasError) {

                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {

                  }
                  return LikeButton(
                    size: 50,
                    circleColor: const CircleColor(
                      start: Color(0xffe320e0),
                      end: Color(0xffee0d70),
                    ),
                    isLiked: like,
                    onTap: (bool isLiked) async {
                      await FirebaseFirestore.instance.collection("post").doc(widget.postModel?.id??"").collection('like').doc(FirebaseAuth.instance.currentUser?.uid??"").set({
                        'like': !isLiked,
                        'id' : FirebaseAuth.instance.currentUser?.uid??"",
                      });
                      final String docId = '${FirebaseAuth.instance.currentUser?.uid}${DateTime.now().microsecondsSinceEpoch}';
                      await FirebaseFirestore.instance.collection('transaction').doc(docId).set({
                        'id': docId,
                        'postEmail': widget.postModel?.email,
                        'postName': widget.postModel?.name,
                        'likedEmail': FirebaseAuth.instance.currentUser?.email,
                        'balance': 0.5
                      });
                      like = await getLike();
                      setState(() {

                      });
                      return like;
                    },
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Color(0xffec8119),
                      dotSecondaryColor: Color(0xff1cdc7c),
                    ),
                    likeBuilder: (bool isLiked){
                      return Icon(
                        Iconsax.lovely,
                        color: like? Colors.red : Colors.grey,
                        size: 35,
                      );
                    },
                    likeCount: snapshot.data?.docs.length,
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<bool> getLike() async{
    DocumentSnapshot<Map<String, dynamic>> doc= await FirebaseFirestore.instance.collection("post").doc(widget.postModel?.id??"").collection('like').doc(FirebaseAuth.instance.currentUser?.uid??"").get();
    return doc.data()?['like']?? false;
  }
}
