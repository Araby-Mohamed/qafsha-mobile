import 'dart:convert';
class StoreResponseModel {
  StoreResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  StoreData data;

  factory StoreResponseModel.fromRawJson(String str) => StoreResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreResponseModel.fromJson(Map<String, dynamic> json) => StoreResponseModel(
    status: json["status"],
    message: json["message"],
    data: StoreData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class StoreData {
  StoreData({
    this.data,
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.totalPages,
  });

  List<StoreDataList> data;
  int total;
  int count;
  int perPage;
  int currentPage;
  int lastPage;
  int totalPages;

  factory StoreData.fromRawJson(String str) => StoreData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
    data: List<StoreDataList>.from(json["data"].map((x) => StoreDataList.fromJson(x))),
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

class StoreDataList {
  StoreDataList({
    this.id,
    this.name,
    this.logo,
    this.distance,
    this.departments,
  });

  int id;
  String name;
  String logo;
  String distance;
  List<Department> departments;

  factory StoreDataList.fromRawJson(String str) => StoreDataList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreDataList.fromJson(Map<String, dynamic> json) => StoreDataList(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    distance: json["distance"],
    departments: List<Department>.from(json["departments"].map((x) => Department.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "distance": distance,
    "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
  };
}

class Department {
  Department({
    this.id,
    this.title,
  });

  int id;
  String title;

  factory Department.fromRawJson(String str) => Department.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Department.fromJson(Map<String, dynamic> json) => Department(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
