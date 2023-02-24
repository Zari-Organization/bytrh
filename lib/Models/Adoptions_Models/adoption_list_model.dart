// To parse this JSON data, do
//
//     final adoptionsListModel = adoptionsListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdoptionsListModel adoptionsListModelFromJson(String str) => AdoptionsListModel.fromJson(json.decode(str));

String adoptionsListModelToJson(AdoptionsListModel data) => json.encode(data.toJson());

class AdoptionsListModel {
  AdoptionsListModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AdoptionsListModel.fromJson(Map<String, dynamic> json) => AdoptionsListModel(
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
    required this.idAdoption,
    required this.petName,
    required this.petStrain,
    required this.petPicture,
    required this.cityName,
    required this.animalSubCategoryName,
    required this.adoptionStatus,
  });

  int idAdoption;
  String petName;
  String petStrain;
  String petPicture;
  String cityName;
  String animalSubCategoryName;
  String adoptionStatus;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAdoption: json["IDAdoption"],
    petName: json["PetName"],
    petStrain: json["PetStrain"],
    petPicture: json["PetPicture"],
    cityName: json["CityName"],
    animalSubCategoryName: json["AnimalSubCategoryName"],
    adoptionStatus: json["AdoptionStatus"],
  );

  Map<String, dynamic> toJson() => {
    "IDAdoption": idAdoption,
    "PetName": petName,
    "PetStrain": petStrain,
    "PetPicture": petPicture,
    "CityName": cityName,
    "AnimalSubCategoryName": animalSubCategoryName,
    "AdoptionStatus": adoptionStatus,
  };
}
