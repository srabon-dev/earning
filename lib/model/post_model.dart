import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? desc;
  final String? email;
  final String? uid;
  final String? id;
  final String? name;
  final bool? isApproved;
  final String? postImage;
  final String? profileImage;
  final Timestamp? createdAt;

  PostModel({
    this.desc,
    this.email,
    this.uid,
    this.id,
    this.name,
    this.isApproved,
    this.postImage,
    this.profileImage,
    this.createdAt,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    desc: json["desc"],
    email: json["email"],
    id: json["id"],
    uid: json["uid"],
    name: json["name"],
    isApproved: json["isApproved"],
    postImage: json["postImage"],
    profileImage: json["profileImage"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "email": email,
    "id": id,
    "uid": uid,
    "name": name,
    "isApproved": isApproved,
    "postImage": postImage,
    "profileImage": profileImage,
    "createdAt": createdAt,
  };
}
