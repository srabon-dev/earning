import 'package:earning/view/widget/loading/custom_loading.dart';
import 'package:flutter/material.dart';

class CardLoading extends StatelessWidget {
  const CardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0,left: 12.0,right: 12.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              //Top Section
              Padding(
                padding: const EdgeInsets.only(left: 8.0,top: 8.0,right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: const CustomLoading(height: 40, width: 40),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const CustomLoading(height: 20, width: 200),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: const CustomLoading(height: 40, width: 40),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12,),
              //Text Section
              CustomLoading(height: 80, width: width),

              SizedBox(height: 12,),
              //Image Section
              CustomLoading(width: width,
                height: height / 7,),
              const SizedBox(height: 8.0),


              //Live Button Section
              const CustomLoading(width: 50, height: 50),
              SizedBox(height: 12,),
            ],
          ),
        ),
      ),
    );
}}
