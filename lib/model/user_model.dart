class UserModel {
  final int? balance;
  final String? email;
  final String? image;
  final bool? isVerified;
  final bool? isPayment;
  final String? name;
  final String? phone;

  UserModel({
    this.balance,
    this.email,
    this.image,
    this.isVerified,
    this.isPayment,
    this.name,
    this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    balance: json["balance"],
    email: json["email"],
    image: json["image"],
    isVerified: json["isVerified"],
    isPayment: json["isPayment"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "email": email,
    "image": image,
    "isVerified": isVerified,
    "isPayment": isPayment,
    "name": name,
    "phone": phone,
  };
}