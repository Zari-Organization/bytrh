// To parse this JSON data, do
//
//     final myBookmarksModel = myBookmarksModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyBookmarksModel myBookmarksModelFromJson(String str) => MyBookmarksModel.fromJson(json.decode(str));

String myBookmarksModelToJson(MyBookmarksModel data) => json.encode(data.toJson());

class MyBookmarksModel {
  MyBookmarksModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory MyBookmarksModel.fromJson(Map<String, dynamic> json) => MyBookmarksModel(
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
  });

  int idAnimalProduct;
  int animalProductPrice;
  String animalProductStatus;
  String animalProductImage;
  int bookmarked;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProduct: json["IDAnimalProduct"],
    animalProductPrice: json["AnimalProductPrice"],
    animalProductStatus: json["AnimalProductStatus"],
    animalProductImage: json["AnimalProductImage"],
    bookmarked: json["Bookmarked"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProduct": idAnimalProduct,
    "AnimalProductPrice": animalProductPrice,
    "AnimalProductStatus": animalProductStatus,
    "AnimalProductImage": animalProductImage,
    "Bookmarked": bookmarked,
  };
}
