// To parse this JSON data, do
//
//     final servicesResponseModel = servicesResponseModelFromJson(jsonString);

import 'dart:convert';

class ServicesResponseModel {
  ServicesResponseModel({
     this.status,
     this.message,
     this.data,
  });

  bool status;
  String message;
  ServicesData data;

  factory ServicesResponseModel.fromRawJson(String str) =>
      ServicesResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      ServicesResponseModel(
        status: json["status"],
        message: json["message"],
        data: ServicesData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class ServicesData {
  ServicesData({
     this.data,
     this.total,
     this.count,
     this.perPage,
     this.currentPage,
     this.lastPage,
     this.totalPages,
  });

  List<ServicesDataList> data;
  int total;
  int count;
  int perPage;
  int currentPage;
  int lastPage;
  int totalPages;
  factory ServicesData.fromRawJson(String str) => ServicesData.fromJson(json.decode(str));
  String toRawJson() => json.encode(toJson());

  factory ServicesData.fromJson(Map<String, dynamic> json) => ServicesData(
        data: List<ServicesDataList>.from(json["data"].map((x) => ServicesDataList.fromJson(x))),
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "last_page": lastPage,
        "total_pages": totalPages,
      };
}

class ServicesDataList {
  ServicesDataList({
     this.id,
     this.title,
     this.image,
  });

  int id;
  String title;
  String image;

  factory ServicesDataList.fromRawJson(String str) => ServicesDataList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ServicesDataList.fromJson(Map<String, dynamic> json) => ServicesDataList(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
      };
}
