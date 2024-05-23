import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:earning/constant/app_images.dart';
import 'package:earning/controller/withdraw_controller.dart';
import 'package:earning/view/widget/app_bar/custom_app_bar.dart';
import 'package:earning/view/widget/loading/image_loading.dart';
import 'package:earning/view/widget/loading/transaction_loding.dart';
import 'package:earning/view/widget/text_field/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(WithdrawController());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: GetBuilder<WithdrawController>(
        builder: (logic) {
          return Scaffold(
            appBar: CustomAppBar(name: "withdraw_coin".tr,isBack: true,),
            body: logic.isWithdrawLoading?const Center(child: ImageLoading(),):SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8.0),
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isDarkMode?AppColors.whiteColor.withOpacity(0.4): AppColors.blackColor.withOpacity(0.1),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  Radio(value: 1, groupValue: logic.selectedValue, onChanged: logic.changeSelectedValue),
                                  Text("bkash".tr,style: Theme.of(context).textTheme.titleLarge)
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(value: 2, groupValue: logic.selectedValue, onChanged: logic.changeSelectedValue),
                                  Text("nagad".tr,style: Theme.of(context).textTheme.titleLarge)
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text("10 coins BDT 1Tk",style: Theme.of(context).textTheme.titleMedium,),
                          const SizedBox(height: 5),

                          //Name TextField -----------------------------
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "name".tr,
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomTextField(
                            hintText: "name".tr,
                            prefixIcon: Iconsax.profile_circle,
                            controller: logic.nameController,
                            validator: (name) {
                              if (logic.nameController.text == "") {
                                return "please_enter_valid_name".tr;
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 12),

                          //Email TextField ---------------------------------
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "bkash_nagad_number".tr,
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          const SizedBox(height: 5),
                          CustomTextField(
                            hintText: "personal_bkash_nagad".tr,
                            prefixIcon: Iconsax.call,
                            textInputType: TextInputType.number,
                            validator: (value){
                              if(RegExp(r'^01[3-9][0-9]{8}$').hasMatch(value ?? '')){
                                return null;
                              }else{
                                return "please_enter_valid_phone_number".tr;
                              }
                            },
                            controller: logic.numberController,
                          ),
                          const SizedBox(height: 12),

                          //Email TextField ---------------------------------
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "coin".tr,
                                style: Theme.of(context).textTheme.titleLarge,
                              )),
                          const SizedBox(height: 5),
                          CustomTextField(
                            hintText: "coin".tr,
                            prefixIcon: Icons.monetization_on_outlined,
                            textInputType: TextInputType.number,
                            validator: (value){
                              if(value != '' && value != null){
                                return null;
                              }else{
                                return "please_enter_withdraw_amount".tr;
                              }
                            },
                            controller: logic.amountController,
                          ),
                          const SizedBox(height: 12),
                          logic.isLoading?const Center(child: CircularProgressIndicator(),): InkWell(
                            onTap: (){
                              if(formKey.currentState!.validate()){
                                if(int.parse(logic.amountController.text.trim()) >= 1000){
                                  logic.sendWithdrawRequest();
                                }else{
                                  Fluttertoast.showToast(msg: "your_account_balance_low".tr);
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange,
                              ),
                              child: Center(child: Text("withdraw".tr,style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColors.whiteColor,
                              ))),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("withdraw_history".tr),
                      Icon(Iconsax.arrow_bottom)
                    ],
                  ),
                  const SizedBox(height: 12),
                  logic.error?Center(child: Text("transaction_not_available".tr)):ListView.separated(
                    itemCount: logic.data?.length??0,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const TransactionLoading();
                    },
                    itemBuilder: (BuildContext context, int index){
                      return Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: logic.data?[index]['provider'] != "Bkash"?Image.asset(AppImages.nagad,fit: BoxFit.cover,):Image.asset(AppImages.bkash,fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(width: 8.0,),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("+88${logic.data?[index]['phone']??""}",style: Theme.of(context).textTheme.titleLarge,),
                                      Text(DateFormat('MM/dd/yyyy, hh:mm a').format(logic.data?[index]['createdAt']?.toDate()??DateTime.now())),
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: isDarkMode ? AppColors.whiteColor.withOpacity(0.4) : AppColors.blackColor.withOpacity(0.1),
                                    ),
                                    child: Center(
                                      child: Text(logic.data?[index]['status']??"",
                                        style: const TextStyle(
                                            color: AppColors.redColor),
                                      ),
                                    ),
                                  ),
                                  Text("- ${logic.data?[index]['amount']??""} Coins",style: const TextStyle(color: AppColors.redColor,),),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  /*StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('withdraw').orderBy("createdAt",descending: true).where('email',isEqualTo: FirebaseAuth.instance.currentUser?.email).snapshots(),
                      builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text("something_went_wrong".tr));
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
                          return Center(child: Text("transaction_not_available".tr));
                        }else if(snapshot.data?.docs.isNotEmpty??false){
                          print(snapshot.data?.docs.isEmpty);
                          return ListView.separated(
                            itemCount: snapshot.data?.docs.length??0,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            separatorBuilder: (BuildContext context, int index) {
                              return const TransactionLoading();
                            },
                            itemBuilder: (BuildContext context, int index){
                              return Card(
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25),
                                              child: snapshot.data?.docs[index]['provider'] != "Bkash"?Image.asset(AppImages.nagad,fit: BoxFit.cover,):Image.asset(AppImages.bkash,fit: BoxFit.cover,),
                                            ),
                                          ),
                                          const SizedBox(width: 8.0,),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("+88${snapshot.data?.docs[index]['phone']??""}",style: Theme.of(context).textTheme.titleLarge,),
                                              Text(DateFormat('MM/dd/yyyy, hh:mm a').format(snapshot.data?.docs[index]['createdAt']?.toDate()??DateTime.now())),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              color: isDarkMode ? AppColors.whiteColor.withOpacity(0.4) : AppColors.blackColor.withOpacity(0.1),
                                            ),
                                            child: Center(
                                              child: Text(snapshot.data?.docs[index]['status']??"",
                                                style: const TextStyle(
                                                    color: AppColors.redColor),
                                              ),
                                            ),
                                          ),
                                          Text("- ${snapshot.data?.docs[index]['amount']??""} Coins",style: const TextStyle(color: AppColors.redColor,),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }else{
                          return Center(child: Text("transaction_not_available".tr));
                        }
                      }
                  ),*/
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
