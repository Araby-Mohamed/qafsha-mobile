// To parse this JSON data, do
//
//     final offerResponseModel = offerResponseModelFromJson(jsonString);

import 'dart:convert';

class OfferResponseModel {
  OfferResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<OfferData> data;

  factory OfferResponseModel.fromRawJson(String str) => OfferResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferResponseModel.fromJson(Map<String, dynamic> json) => OfferResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<OfferData>.from(json["data"].map((x) => OfferData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OfferData {
  OfferData({
    this.id,
    this.userId,
    this.orderId,
    this.username,
    this.price,
    this.image,
    this.rate,
    this.distance,
  });

  int id;
  int orderId;
  int userId;
  String username;
  String price;
  String image;
  int rate;
  String distance;

  factory OfferData.fromRawJson(String str) => OfferData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OfferData.fromJson(Map<String, dynamic> json) => OfferData(
    id: json["id"],
    orderId: json["order_id"],
    userId: json["user_id"],
    username: json["username"],
    price: json["price"],
    image: json["image"],
    rate: json["rate"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user_id": userId,
    "username": username,
    "price": price,
    "image": image,
    "rate": rate,
    "distance": distance,
  };
}
