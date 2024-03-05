import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:earning/constant/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 24),
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isDarkMode?AppColors.whiteColor.withOpacity(0.4): AppColors.blackColor.withOpacity(0.1),
                ),
                child: Column(
                  children: [
                    const Text("0.0Tk",style: TextStyle(fontSize: 38,fontFamily: "Bold",fontWeight: FontWeight.w800),),
                    const Text("more like more earning!",style: TextStyle(fontSize: 14,fontFamily: "Bold",fontWeight: FontWeight.w800),),
                    const SizedBox(height: 12),
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.orange,
                        ),
                        child: Center(child: Text("Withdraw",style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.whiteColor,
                        ))),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('transaction').where('postEmail',isEqualTo: FirebaseAuth.instance.currentUser?.email).snapshots(),
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
                          return const SizedBox();
                        },
                      );
                    }
                    if(snapshot.data?.docs.isEmpty??false){
                      return const Center(child: Text("No posts available"));
                    }else{
                      return ListView.separated(
                        itemCount: snapshot.data?.docs.length??0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox();
                        },
                        itemBuilder: (BuildContext context, int index){
                          return Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ListTile(
                              title: Text("Srabon Bapari"),
                              subtitle: Text("8/5/12"),
                              trailing: Text("0.5Tk"),
                            ),
                          );
                        },
                      );
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
