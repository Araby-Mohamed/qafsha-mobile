// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

class ProfileResponseModel {
  ProfileResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  UserProfile data;

  factory ProfileResponseModel.fromRawJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    status: json["status"],
    message: json["message"],
    data: UserProfile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class UserProfile {
  UserProfile({
    this.id,
    this.username,
    this.email,
    this.phone,
    this.image,
  });

  int id;
  String username;
  String email;
  String phone;
  String image;

  factory UserProfile.fromRawJson(String str) => UserProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phone": phone,
    "image": image,
  };
}
