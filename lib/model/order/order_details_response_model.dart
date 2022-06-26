import 'dart:convert';

class OrderDetailsResponseModel {
  OrderDetailsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  OrderDetailsList data;

  factory OrderDetailsResponseModel.fromRawJson(String str) => OrderDetailsResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailsResponseModel.fromJson(Map<String, dynamic> json) => OrderDetailsResponseModel(
    status: json["status"],
    message: json["message"],
    data: OrderDetailsList.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class OrderDetailsList {
  OrderDetailsList({
    this.id,
    this.orderNumber,
    this.status,
    this.total,
    this.paymentMethod,
    this.date,
    this.received,
    this.shippingDetails,
    this.products,
  });

  int id;
  int orderNumber;
  String status;
  String total;
  String paymentMethod;
  String date;
  bool received;
  ShippingDetails shippingDetails;
  List<Product> products;

  factory OrderDetailsList.fromRawJson(String str) => OrderDetailsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderDetailsList.fromJson(Map<String, dynamic> json) => OrderDetailsList(
    id: json["id"],
    orderNumber: json["order_number"],
    status: json["status"],
    total: json["total"],
    paymentMethod: json["payment_method"],
    date: json["date"],
    received: json["received"],
    shippingDetails: ShippingDetails.fromJson(json["shipping_details"]),
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_number": orderNumber,
    "status": status,
    "total": total,
    "payment_method": paymentMethod,
    "date": date,
    "received": received,
    "shipping_details": shippingDetails.toJson(),
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
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

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

class ShippingDetails {
  ShippingDetails({
    this.userId,
    this.phone,
    this.username,
    this.address,
    this.shippingExpenses,
    this.totalIncludesShippingCosts,
  });

  int userId;
  String phone;
  String username;
  String address;
  String shippingExpenses;
  int totalIncludesShippingCosts;

  factory ShippingDetails.fromRawJson(String str) => ShippingDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ShippingDetails.fromJson(Map<String, dynamic> json) => ShippingDetails(
    userId: json["user_id"],
    phone: json["phone"],
    username: json["username"],
    address: json["address"],
    shippingExpenses: json["shipping_expenses"],
    totalIncludesShippingCosts: json["total_includes_shipping_costs"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "phone": phone,
    "username": username,
    "address": address,
    "shipping_expenses": shippingExpenses,
    "total_includes_shipping_costs": totalIncludesShippingCosts,
  };
}

