// To parse this JSON data, do
//
//     final departmentsResponseModel = departmentsResponseModelFromJson(jsonString);

import 'dart:convert';

class DepartmentsResponseModel {
  DepartmentsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<DepartmentsDataList> data;

  factory DepartmentsResponseModel.fromRawJson(String str) => DepartmentsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DepartmentsResponseModel.fromJson(Map<String, dynamic> json) => DepartmentsResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<DepartmentsDataList>.from(json['data']['data'].map((x) => DepartmentsDataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class DepartmentsDataList {
  DepartmentsDataList({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory DepartmentsDataList.fromRawJson(String str) => DepartmentsDataList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DepartmentsDataList.fromJson(Map<String, dynamic> json) => DepartmentsDataList(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
