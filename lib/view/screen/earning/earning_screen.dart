import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/core/route/app_route.dart';
import 'package:earning/model/transaction_model.dart';
import 'package:earning/view/widget/loading/custom_loading.dart';
import 'package:earning/view/widget/loading/transaction_loding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(onPressed: (){
          Get.toNamed(AppRoute.messageScreen);
        },label: const Column(
          children: [
            Icon(Iconsax.message),
            Text("Need Support"),
          ],
        ),),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 24),
              FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser?.uid).get(),
                builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot?> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isDarkMode?AppColors.whiteColor.withOpacity(0.4): AppColors.blackColor.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          const CustomLoading(height: 20, width: 100),
                          const SizedBox(height: 12,),
                          CustomLoading(height: 14, width: width/6),
                          const SizedBox(height: 12),
                          CustomLoading(height: 60, width: width),
                        ],
                      ),
                    );
                  }
                  if(snapshot.data!.exists){
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isDarkMode?AppColors.whiteColor.withOpacity(0.4): AppColors.blackColor.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${snapshot.data?['balance'].toInt()??""}",style: const TextStyle(fontSize: 28,fontFamily: "Bold",fontWeight: FontWeight.w800),),
                              const Text(" Coin"),
                            ],
                          ),
                          const Text("more like more earning!",style: TextStyle(fontSize: 14,fontFamily: "Bold",fontWeight: FontWeight.w800),),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: (){
                              Get.toNamed(AppRoute.withdrawScreen);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              child: Center(child: Text("Withdraw Coin",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.whiteColor,
                              ))),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                    width: width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: isDarkMode?AppColors.whiteColor.withOpacity(0.4): AppColors.blackColor.withOpacity(0.1),
                    ),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("0",style: TextStyle(fontSize: 28,fontFamily: "Bold",fontWeight: FontWeight.w800),),
                            Text(" Coin"),
                          ],
                        ),
                        const Text("more like more earning!",style: TextStyle(fontSize: 14,fontFamily: "Bold",fontWeight: FontWeight.w800),),
                        const SizedBox(height: 12),
                        InkWell(
                          onTap: (){
                            Get.toNamed(AppRoute.withdrawScreen);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.orange,
                            ),
                            child: Center(child: Text("Withdraw Coin",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.whiteColor,
                            ))),
                          ),
                        )
                      ],
                    ),
                  );
                }
              ),
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Transaction"),
                  Icon(Iconsax.arrow_bottom)
                ],
              ),
              const SizedBox(height: 12),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('transaction').orderBy("createdAt",descending: true).where('postEmail',isEqualTo: FirebaseAuth.instance.currentUser?.email).snapshots(),
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
                          return const TransactionLoading();
                        },
                      );
                    }
                    if(snapshot.data?.docs.isEmpty??false){
                      return const Center(child: Text("Transaction not available"));
                    }else if(snapshot.data?.docs.isNotEmpty??false){
                      return ListView.separated(
                        itemCount: snapshot.data?.docs.length??0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox();
                        },
                        itemBuilder: (BuildContext context, int index){
                          TransactionModel transactionModel = TransactionModel(
                            balance: snapshot.data?.docs[index]['balance'].toInt(),
                            id: snapshot.data?.docs[index]['id'],
                            postId: snapshot.data?.docs[index]['postId'],
                            likedEmail: snapshot.data?.docs[index]['likedEmail'],
                            likedName: snapshot.data?.docs[index]['likedName'],
                            postEmail: snapshot.data?.docs[index]['postEmail'],
                            postName: snapshot.data?.docs[index]['postName'],
                            image: snapshot.data?.docs[index]['image'],
                            createdAt: snapshot.data?.docs[index]['createdAt'],
                          );
                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              title: Text(transactionModel.likedName??""),
                              subtitle: Text(DateFormat('MM/dd/yyyy, hh:mm a').format(transactionModel.createdAt?.toDate()??DateTime.now())),
                              trailing: Text("+ ${transactionModel.balance}Coin",style: const TextStyle(color: AppColors.greenColor,),),
                              leading: SizedBox(
                                height: 50,
                                width: 50,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: transactionModel.image != ""?CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                      const CustomLoading(width: 50, height: 50),
                                      errorWidget: (context, url, error) =>
                                      const Icon(Iconsax.profile_circle,size: 35,),
                                      imageUrl: transactionModel.image!):Image.asset(AppImages.profile,fit: BoxFit.cover,),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }else{
                      return const Center(child: Text("Transaction not available"));
                    }
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
