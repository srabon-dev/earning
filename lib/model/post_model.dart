class PostModel {
  final String? desc;
  final String? email;
  final String? id;
  final String? name;
  final bool? isApproved;
  final String? postImage;
  final String? profileImage;

  PostModel({
    this.desc,
    this.email,
    this.id,
    this.name,
    this.isApproved,
    this.postImage,
    this.profileImage,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    desc: json["desc"],
    email: json["email"],
    id: json["id"],
    name: json["name"],
    isApproved: json["isApproved"],
    postImage: json["postImage"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "email": email,
    "id": id,
    "name": name,
    "isApproved": isApproved,
    "postImage": postImage,
    "profileImage": profileImage,
  };
}
