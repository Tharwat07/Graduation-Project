// To parse this JSON data, do
//
//     final BundleResponse = BundleResponseFromJson(jsonString);

import 'dart:convert';
import 'dart:core';


BundleResponse bundleResponseFromJson(String str) => BundleResponse.fromJson(json.decode(str));

String bundleResponseToJson(BundleResponse data) => json.encode(data.toJson());

class BundleResponse {
  BundleResponse({
    this.bundles,
    this.success,
    this.status,
  });

  List<BundleResponseDatum> bundles;
  bool success;
  int status;

  factory BundleResponse.fromJson(Map<String, dynamic> json) => BundleResponse(
    bundles: List<BundleResponseDatum>.from(json["data"].map((x) => BundleResponseDatum.fromJson(x))),
    success: json["success"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(bundles.map((x) => x.toJson())),
    "success": success,
    "status": status,
  };
}

class BundleResponseDatum {
  BundleResponseDatum({
    this.id,
    this.title,
    this.date,
    this.main_price,
    this.price_after_discount,
    this.banner,
    this.products,
  });

  int id;
  String title;
  int date;
  int main_price;
  int price_after_discount;
  String banner;
  Products products;

  factory BundleResponseDatum.fromJson(Map<String, dynamic> json) => BundleResponseDatum(
    id: json["id"],
    title: json["title"],
    date: json["date"],
    main_price: json["main_price"],
    price_after_discount: json["price_after_discount"],
    banner: json["banner"],
    products: Products.fromJson(json["products"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date,
    "main_price":main_price,
    "price_after_discount":price_after_discount,
    "banner": banner,
    "products": products.toJson(),
  };
}

class Products {
  Products({
    this.products,
  });

  List<Product> products;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
    products: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.image,
    this.links,
  });

  var id;
  String name;
  String price;
  String image;
  Links links;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    links: Links.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "links": links.toJson(),
  };
}

class Links {
  Links({
    this.details,
  });

  String details;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    details: json["details"],
  );

  Map<String, dynamic> toJson() => {
    "details": details,
  };
}
