// To parse this JSON data, do
//
//     final adoptionAnimalsCategoriesModel = adoptionAnimalsCategoriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdoptionAnimalsCategoriesModel adoptionAnimalsCategoriesModelFromJson(String str) => AdoptionAnimalsCategoriesModel.fromJson(json.decode(str));

String adoptionAnimalsCategoriesModelToJson(AdoptionAnimalsCategoriesModel data) => json.encode(data.toJson());

class AdoptionAnimalsCategoriesModel {
  AdoptionAnimalsCategoriesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AdoptionAnimalsCategoriesModel.fromJson(Map<String, dynamic> json) => AdoptionAnimalsCategoriesModel(
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
  });

  int idAnimalSubCategory;
  String animalSubCategoryName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalSubCategory: json["IDAnimalSubCategory"],
    animalSubCategoryName: json["AnimalSubCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalSubCategory": idAnimalSubCategory,
    "AnimalSubCategoryName": animalSubCategoryName,
  };
}
