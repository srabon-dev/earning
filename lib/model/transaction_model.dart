import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final int? balance;
  final Timestamp? createdAt;
  final String? id;
  final String? likedEmail;
  final String? likedName;
  final String? postEmail;
  final String? postName;
  final String? postId;
  final String? image;

  TransactionModel({
    this.balance,
    this.createdAt,
    this.id,
    this.postId,
    this.likedEmail,
    this.likedName,
    this.postEmail,
    this.postName,
    this.image,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    balance: json["balance"]?.toInt(),
    createdAt: json["createdAt"],
    id: json["id"],
    postId: json["postId"],
    likedEmail: json["likedEmail"],
    likedName: json["likedName"],
    postEmail: json["postEmail"],
    postName: json["postName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "createdAt": createdAt,
    "id": id,
    "postId": postId,
    "likedEmail": likedEmail,
    "likedName": likedName,
    "postEmail": postEmail,
    "postName": postName,
    "image": image,
  };
}
