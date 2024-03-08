import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String? id;
  final String? uid;
  final String? email;
  final String? name;
  final String? image;
  final String? postImage;
  final String? message;
  final String? receive;
  final bool? isMe;
  final bool? isImage;
  final Timestamp? createdAt;

  MessageModel({
    this.id,
    this.uid,
    this.email,
    this.name,
    this.image,
    this.postImage,
    this.message,
    this.receive,
    this.isMe,
    this.isImage,
    this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    id: json["id"],
    uid: json["uid"],
    email: json["email"],
    name: json["name"],
    image: json["image"],
    postImage: json["postImage"],
    message: json["message"],
    receive: json["receive"],
    isMe: json["isMe"],
    isImage: json["isImage"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uid": uid,
    "email": email,
    "name": name,
    "image": image,
    "postImage": postImage,
    "message": message,
    "receive": receive,
    "isMe": isMe,
    "isImage": isImage,
    "createdAt": createdAt,
  };
}