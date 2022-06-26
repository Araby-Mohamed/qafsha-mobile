// To parse this JSON data, do
//
//     final beforeConfirmResponseModel = beforeConfirmResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class CardOrders {
  String storeList;
  List<OrderProductData> productsList;

  CardOrders({@required this.storeList, @required this.productsList});
}

class BeforeConfirmResponseModel {
  BeforeConfirmResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  dynamic message;
  BeforeConfirmData data;

  factory BeforeConfirmResponseModel.fromRawJson(String str) =>
      BeforeConfirmResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BeforeConfirmResponseModel.fromJson(Map<String, dynamic> json) {
    return BeforeConfirmResponseModel(
      status: json["status"],
      message: json["message"],
      data: BeforeConfirmData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class BeforeConfirmData {
  BeforeConfirmData({
    this.freyaBuckley,
    this.paymentMethod,
    this.orderDeliverySite,
    this.deliveryTime,
    this.total,
  });

  List<OrderProductData> freyaBuckley;
  String paymentMethod;
  String orderDeliverySite;
  String deliveryTime;
  int total;

  factory BeforeConfirmData.fromRawJson(String str) =>
      BeforeConfirmData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BeforeConfirmData.fromJson(Map<String, dynamic> json) {
    return BeforeConfirmData(
      freyaBuckley: List<OrderProductData>.from(
          getList(json).map((x) => OrderProductData.fromJson(x))),
      paymentMethod: json["payment_method"],
      orderDeliverySite: json["order_delivery_site"],
      deliveryTime: json["delivery_time"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
        "Freya Buckley":
            List<dynamic>.from(freyaBuckley.map((x) => x.toJson())),
        "payment_method": paymentMethod,
        "order_delivery_site": orderDeliverySite,
        "delivery_time": deliveryTime,
        "total": total,
      };
}

List<dynamic> getList(Map<String, dynamic> json) {
  List<dynamic> dataList;
  json.values.forEach((elements) {
    if (elements is List) dataList = elements;
  });
  return dataList;
}

class OrderProductData {
  OrderProductData({
    this.id,
    this.productId,
    this.productTitle,
    this.productQuantity,
    this.productPrice,
    this.productImage,
    this.storeId,
    this.storeName,
  });

  int id;
  int productId;
  String productTitle;
  int productQuantity;
  int productPrice;
  String productImage;
  int storeId;
  String storeName;

  factory OrderProductData.fromRawJson(String str) =>
      OrderProductData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderProductData.fromJson(Map<String, dynamic> json) =>
      OrderProductData(
        id: json["id"],
        productId: json["product_id"],
        productTitle: json["product_title"],
        productQuantity: json["product_quantity"],
        productPrice: json["product_price"],
        productImage: json["product_image"],
        storeId: json["store_id"],
        storeName: json["store_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_title": productTitle,
        "product_quantity": productQuantity,
        "product_price": productPrice,
        "product_image": productImage,
        "store_id": storeId,
        "store_name": storeName,
      };
}
