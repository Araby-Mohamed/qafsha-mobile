// To parse this JSON data, do
//
//     final productAndFastFoodResponseModel = productAndFastFoodResponseModelFromJson(jsonString);

import 'dart:convert';

class ProductAndFastFoodResponseModel {
  ProductAndFastFoodResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<ProductAndFastFoodData> data;

  factory ProductAndFastFoodResponseModel.fromRawJson(String str) => ProductAndFastFoodResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAndFastFoodResponseModel.fromJson(Map<String, dynamic> json) => ProductAndFastFoodResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<ProductAndFastFoodData>.from(json["data"]['data'].map((x) => ProductAndFastFoodData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductAndFastFoodData {
  ProductAndFastFoodData({
    this.id,
    this.title,
    this.price,
    this.image,
    this.counter = 1,
  });

  int id, counter;
  String title;
  String price;
  String image;

  factory ProductAndFastFoodData.fromRawJson(String str) => ProductAndFastFoodData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductAndFastFoodData.fromJson(Map<String, dynamic> json) => ProductAndFastFoodData(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    image: json["image"],
    counter:  1
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
    "image": image,
  };
}
