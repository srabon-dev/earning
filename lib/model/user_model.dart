import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final int? balance;
  final String? email;
  final String? image;
  final bool? isVerified;
  final String? name;
  final String? phone;
  final String? verificationStatus;
  final Timestamp? createdAt;

  UserModel({
    this.balance,
    this.email,
    this.image,
    this.isVerified = false,
    this.verificationStatus,
    this.name,
    this.phone,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    balance: json["balance"].toInt(),
    email: json["email"],
    image: json["image"],
    isVerified: json["isVerified"],
    verificationStatus: json["verificationStatus"],
    name: json["name"],
    phone: json["phone"],
    createdAt: json["createdAt"]
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "email": email,
    "image": image,
    "isVerified": isVerified,
    "verificationStatus": verificationStatus,
    "name": name,
    "phone": phone,
    "createdAt": createdAt,
  };
}