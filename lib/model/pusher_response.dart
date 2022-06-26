
import 'dart:convert';

class PusherResponse {
  PusherResponse({
    this.id,
    this.orderId,
    this.driverId,
    this.userId,
    this.username,
    this.price,
    this.image,
    this.rate,
    this.distance,
  });

  final int id;
  final String orderId;
  final int driverId;
  final int userId;
  final String username;
  final String price;
  final String image;
  final int rate;
  final String distance;

  factory PusherResponse.fromRawJson(String str) => PusherResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PusherResponse.fromJson(Map<String, dynamic> json) => PusherResponse(
    id: json["id"],
    orderId: json["order_id"],
    driverId: json["driver_id"],
    userId: json["user_id"],
    username: json["username"],
    price: json["price"],
    image: json["image"],
    rate: json["rate"],
    distance: json["distance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "driver_id": driverId,
    "user_id": userId,
    "username": username,
    "price": price,
    "image": image,
    "rate": rate,
    "distance": distance,
  };
}
