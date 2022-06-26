// To parse this JSON data, do
//
//     final productStoreDetailsResponseModel = productStoreDetailsResponseModelFromJson(jsonString);

import 'dart:convert';
class ProductStoreDetailsData {
  ProductStoreDetailsData({
    this.id,
    this.title,
    this.description,
    this.image,
    this.price,
    this.additions,
  });

  int id;
  String title;
  String description;
  String image;
  String price;
  List<Addition> additions;

  factory ProductStoreDetailsData.fromRawJson(String str) => ProductStoreDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProductStoreDetailsData.fromJson(Map<String, dynamic> json) => ProductStoreDetailsData(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    price: json["price"],
    additions: List<Addition>.from(json["additions"].map((x) => Addition.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "price": price,
    "additions": List<dynamic>.from(additions.map((x) => x.toJson())),
  };
}

class Addition {
  Addition({
    this.id,
    this.title,
    this.price,
  });

  int id;
  String title;
  String price;

  factory Addition.fromRawJson(String str) => Addition.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Addition.fromJson(Map<String, dynamic> json) => Addition(
    id: json["id"],
    title: json["title"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
  };
}
