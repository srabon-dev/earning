import 'package:earning/view/widget/loading/custom_loading.dart';
import 'package:flutter/material.dart';

class TransactionLoading extends StatelessWidget {
  const TransactionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const ListTile(
          title: Padding(
            padding: EdgeInsets.all(8.0),
            child: CustomLoading(height: 20, width: 80),
          ),
          subtitle: CustomLoading(height: 20, width: 100),
          trailing: Column(
            children: [
              CustomLoading(height: 20, width: 80),
              SizedBox(height: 5.0,),
              CustomLoading(height: 18, width: 160),
            ],
          ),
          leading: CustomLoading(height: 50, width: 50,borderRadius: 25,),
        ),
      ),
    );
  }
}
