// To parse this JSON data, do
//
//     final productsMyAnimalsModel = productsMyAnimalsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsMyAnimalsModel productsMyAnimalsModelFromJson(String str) => ProductsMyAnimalsModel.fromJson(json.decode(str));

String productsMyAnimalsModelToJson(ProductsMyAnimalsModel data) => json.encode(data.toJson());

class ProductsMyAnimalsModel {
  ProductsMyAnimalsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ProductsMyAnimalsModel.fromJson(Map<String, dynamic> json) => ProductsMyAnimalsModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    required this.idAnimalProduct,
    required this.animalProductPrice,
    required this.animalProductImage,
    required this.bookmarked,
  });

  int idAnimalProduct;
  int animalProductPrice;
  String animalProductImage;
  int bookmarked;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProduct: json["IDAnimalProduct"],
    animalProductPrice: json["AnimalProductPrice"],
    animalProductImage: json["AnimalProductImage"],
    bookmarked: json["Bookmarked"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProduct": idAnimalProduct,
    "AnimalProductPrice": animalProductPrice,
    "AnimalProductImage": animalProductImage,
    "Bookmarked": bookmarked,
  };
}
