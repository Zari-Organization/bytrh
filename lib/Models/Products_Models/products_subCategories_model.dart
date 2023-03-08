// To parse this JSON data, do
//
//     final productsSubCategoriesModel = productsSubCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsSubCategoriesModel productsSubCategoriesModelFromJson(String str) => ProductsSubCategoriesModel.fromJson(json.decode(str));

String productsSubCategoriesModelToJson(ProductsSubCategoriesModel data) => json.encode(data.toJson());

class ProductsSubCategoriesModel {
  ProductsSubCategoriesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ProductsSubCategoriesModel.fromJson(Map<String, dynamic> json) => ProductsSubCategoriesModel(
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
    required this.idAnimalSubCategory,
    required this.animalSubCategoryName,
    required this.animalSubCategoryImage,
  });

  int idAnimalSubCategory;
  String animalSubCategoryName;
  String animalSubCategoryImage;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalSubCategory: json["IDAnimalSubCategory"],
    animalSubCategoryName: json["AnimalSubCategoryName"],
    animalSubCategoryImage: json["AnimalSubCategoryImage"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalSubCategory": idAnimalSubCategory,
    "AnimalSubCategoryName": animalSubCategoryName,
    "AnimalSubCategoryImage": animalSubCategoryImage,
  };
}
