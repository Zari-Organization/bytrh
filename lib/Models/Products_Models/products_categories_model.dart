// To parse this JSON data, do
//
//     final productsCategoriesModel = productsCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsCategoriesModel productsCategoriesModelFromJson(String str) => ProductsCategoriesModel.fromJson(json.decode(str));

String productsCategoriesModelToJson(ProductsCategoriesModel data) => json.encode(data.toJson());

class ProductsCategoriesModel {
  ProductsCategoriesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ProductsCategoriesModel.fromJson(Map<String, dynamic> json) => ProductsCategoriesModel(
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
    required this.idAnimalCategory,
    required this.animalCategoryName,
    required this.animalCategoryImage,
  });

  int idAnimalCategory;
  String animalCategoryName;
  String animalCategoryImage;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalCategory: json["IDAnimalCategory"],
    animalCategoryName: json["AnimalCategoryName"],
    animalCategoryImage: json["AnimalCategoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalCategory": idAnimalCategory,
    "AnimalCategoryName": animalCategoryName,
    "AnimalCategoryImage": animalCategoryImage,
  };
}
