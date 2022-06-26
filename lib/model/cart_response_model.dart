
import 'dart:convert';

class CartResponseModel {
  CartResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  dynamic message;
  List<CartData> data;

  factory CartResponseModel.fromRawJson(String str) => CartResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartResponseModel.fromJson(Map<String, dynamic> json) => CartResponseModel(
    status: json["status"],
    message: json["message"],
    data: List<CartData>.from(json["data"].map((x) => CartData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CartData {
  CartData({
    this.id,
    this.product,
    this.quantity,
    this.priceAdditions,
    this.total,
  });

  int id;
  Product product;
  int quantity;
  int priceAdditions;
  int total;

  factory CartData.fromRawJson(String str) => CartData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CartData.fromJson(Map<String, dynamic> json) => CartData(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
    priceAdditions: json["price_additions"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
    "quantity": quantity,
    "price_additions": priceAdditions,
    "total": total,
  };
}

class Product {
  Product({
    this.id,
    this.title,
    this.price,
  });

  int id;
  String title;
  String price;

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    title: json["title"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "price": price,
  };
}
