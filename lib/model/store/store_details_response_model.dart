// To parse this JSON data, do
//
//     final storeDetailsResponseModel = storeDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

class StoreDetailsData {
  StoreDetailsData({
    this.id,
    this.name,
    this.open = false,
    this.city,
    this.distance,
  });

  int id;
  String name;
  bool open;
  String city;
  String distance;

  factory StoreDetailsData.fromRawJson(String str) =>
      StoreDetailsData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StoreDetailsData.fromJson(Map<String, dynamic> json) {
    print('json data data data => ${json['data']}');
   return StoreDetailsData(
      id: json["id"],
      name: json["name"],
      open: json["open"] == null ? false : json["open"] ,
      city: json["city"],
      distance: json["distance"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "open": open,
        "city": city,
        "distance": distance,
      };

  @override
  String toString() {
    return 'StoreDetailsData{id: $id, name: $name, open: $open, city: $city, distance: $distance}';
  }
}
