// To parse this JSON data, do
//
//     final receivedOrderResponseModel = receivedOrderResponseModelFromJson(jsonString);

import 'dart:convert';

class ReceivedOrderResponseModel {
  ReceivedOrderResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  ReceivedOrderList data;

  factory ReceivedOrderResponseModel.fromRawJson(String str) => ReceivedOrderResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivedOrderResponseModel.fromJson(Map<String, dynamic> json) => ReceivedOrderResponseModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] is Map ? ReceivedOrderList.fromJson(json["data"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class ReceivedOrderList {
  ReceivedOrderList({
    this.id,
    this.orderNumber,
    this.deliveryName,
    this.storeAndProducts,
    this.total,
  });

  int id;
  int orderNumber;
  String deliveryName;
  List<StoreAndProduct> storeAndProducts;
  int total;

  factory ReceivedOrderList.fromRawJson(String str) => ReceivedOrderList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReceivedOrderList.fromJson(Map<String, dynamic> json) => ReceivedOrderList(
    id: json["id"],
    orderNumber: json["order_number"],
    deliveryName: json["delivery_name"],
    storeAndProducts: List<StoreAndProduct>.from(json["store_and_products"].map((x) => StoreAndProduct.fromJson(x))),
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "delivery_name": deliveryName,
    "store_and_products": List<dynamic>.from(storeAndProducts.map((x) => x.toJson())),
    "total": total,
  };
}

class StoreAndProduct {
  StoreAndProduct({
    this.title,
    this.description,
    this.store,
    this.quantity,
    this.productImage,
  });

  String title;
  String description;
  String store;
  int quantity;
  String productImage;

  factory StoreAndProduct.fromRawJson(String str) => StoreAndProduct.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreAndProduct.fromJson(Map<String, dynamic> json) => StoreAndProduct(
    title: json["title"],
    description: json["description"],
    store: json["store"],
    quantity: json["quantity"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "store": store,
    "quantity": quantity,
    "product_image": productImage,
  };
}
