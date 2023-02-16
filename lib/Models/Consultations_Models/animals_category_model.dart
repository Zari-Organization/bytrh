// To parse this JSON data, do
//
//     final animalsCategoryModel = animalsCategoryModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnimalsCategoryModel animalsCategoryModelFromJson(String str) => AnimalsCategoryModel.fromJson(json.decode(str));

String animalsCategoryModelToJson(AnimalsCategoryModel data) => json.encode(data.toJson());

class AnimalsCategoryModel {
  AnimalsCategoryModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AnimalsCategoryModel.fromJson(Map<String, dynamic> json) => AnimalsCategoryModel(
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
  });

  int idAnimalCategory;
  String animalCategoryName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalCategory: json["IDAnimalCategory"],
    animalCategoryName: json["AnimalCategoryName"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalCategory": idAnimalCategory,
    "AnimalCategoryName": animalCategoryName,
  };
}
