// To parse this JSON data, do
//
//     final animalProductsModel = animalProductsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnimalProductsModel animalProductsModelFromJson(String str) => AnimalProductsModel.fromJson(json.decode(str));

String animalProductsModelToJson(AnimalProductsModel data) => json.encode(data.toJson());

class AnimalProductsModel {
  AnimalProductsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AnimalProductsModel.fromJson(Map<String, dynamic> json) => AnimalProductsModel(
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
  });

  int idAnimalProduct;
  int animalProductPrice;
  String animalProductImage;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProduct: json["IDAnimalProduct"],
    animalProductPrice: json["AnimalProductPrice"],
    animalProductImage: json["AnimalProductImage"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProduct": idAnimalProduct,
    "AnimalProductPrice": animalProductPrice,
    "AnimalProductImage": animalProductImage,
  };
}
