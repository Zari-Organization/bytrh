// To parse this JSON data, do
//
//     final productsAnimalsRequestsModel = productsAnimalsRequestsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsAnimalsRequestsModel productsAnimalsRequestsModelFromJson(String str) => ProductsAnimalsRequestsModel.fromJson(json.decode(str));

String productsAnimalsRequestsModelToJson(ProductsAnimalsRequestsModel data) => json.encode(data.toJson());

class ProductsAnimalsRequestsModel {
  ProductsAnimalsRequestsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ProductsAnimalsRequestsModel.fromJson(Map<String, dynamic> json) => ProductsAnimalsRequestsModel(
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
    required this.animalProductStatus,
    required this.animalProductImage,
    required this.bookmarked,
     this.deliveryFees,
  });

  int idAnimalProduct;
  int animalProductPrice;
  String animalProductStatus;
  String animalProductImage;
  int bookmarked;
  final deliveryFees;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProduct: json["IDAnimalProduct"],
    animalProductPrice: json["AnimalProductPrice"],
    animalProductStatus: json["AnimalProductStatus"],
    animalProductImage: json["AnimalProductImage"],
    bookmarked: json["Bookmarked"],
    deliveryFees: json["DeliveryFees"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProduct": idAnimalProduct,
    "AnimalProductPrice": animalProductPrice,
    "AnimalProductStatus": animalProductStatus,
    "AnimalProductImage": animalProductImage,
    "Bookmarked": bookmarked,
    "DeliveryFees": deliveryFees,
  };
}
