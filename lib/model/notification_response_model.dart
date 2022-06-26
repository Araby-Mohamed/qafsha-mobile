// To parse this JSON data, do
//
//     final notificationResponseModel = notificationResponseModelFromJson(jsonString);

import 'dart:convert';

class NotificationResponseModel {
  NotificationResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<NotificationList> data;

  factory NotificationResponseModel.fromRawJson(String str) => NotificationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<NotificationList>.from(json["data"].map((x) => NotificationList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationList {
  NotificationList({
    this.orderNumber,
    this.orderId,
    this.status,
    this.date,
  });

  int orderNumber;
  int orderId;
  String status;
  String date;

  factory NotificationList.fromRawJson(String str) => NotificationList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
    orderNumber: json["order_number"],
    orderId: json["order_id"],
    status: json["status"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "order_number": orderNumber,
    "order_id": orderId,
    "status": status,
    "date": date,
  };
}
