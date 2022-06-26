// To parse this JSON data, do
//
//     final settingResponseModel = settingResponseModelFromJson(jsonString);

import 'dart:convert';

class SettingResponseModel {
  SettingResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<SettingData> data;

  factory SettingResponseModel.fromRawJson(String str) => SettingResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingResponseModel.fromJson(Map<String, dynamic> json) => SettingResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<SettingData>.from(json["data"].map((x) => SettingData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SettingData {
  SettingData({
    this.id,
    this.pageName,
    this.content,
  });

  int id;
  String pageName;
  String content;

  factory SettingData.fromRawJson(String str) => SettingData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SettingData.fromJson(Map<String, dynamic> json) => SettingData(
    id: json["id"],
    pageName: json["page_name"],
    content: json["content"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "page_name": pageName,
    "content": content,
  };
}
