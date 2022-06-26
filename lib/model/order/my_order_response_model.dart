// To parse this JSON data, do
//
//     final myOrderResponseModel = myOrderResponseModelFromJson(jsonString);

import 'dart:convert';

class MyOrderResponseModel {
  MyOrderResponseModel({
    this.data,
  });

  List<OrderDataList> data;

  factory MyOrderResponseModel.fromRawJson(String str) => MyOrderResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MyOrderResponseModel.fromJson(Map<String, dynamic> json) => MyOrderResponseModel(
    data: List<OrderDataList>.from(json["data"].map((x) => OrderDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class OrderDataList {
  OrderDataList({
    this.id,
    this.orderNumber,
    this.date,
    this.status,
    this.products,
  });

  int id;
  int orderNumber;
  String date;
  String status;
  List<Product> products;

  factory OrderDataList.fromRawJson(String str) => OrderDataList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDataList.fromJson(Map<String, dynamic> json) => OrderDataList(
    id: json["id"],
    orderNumber: json["order_number"],
    date: json["date"],
    status: json["status"],
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "date": date,
    "status": status,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.productId,
    this.title,
    this.image,
    this.price,
    this.quantity,
  });

  int id;
  int productId;
  String title;
  String image;
  int price;
  int quantity;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    productId: json["product_id"],
    title: json["title"],
    image: json["image"],
    price: json["price"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_id": productId,
    "title": title,
    "image": image,
    "price": price,
    "quantity": quantity,
  };
}
