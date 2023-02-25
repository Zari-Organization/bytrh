// To parse this JSON data, do
//
//     final adoptionDetailsModel = adoptionDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdoptionDetailsModel adoptionDetailsModelFromJson(String str) => AdoptionDetailsModel.fromJson(json.decode(str));

String adoptionDetailsModelToJson(AdoptionDetailsModel data) => json.encode(data.toJson());

class AdoptionDetailsModel {
  AdoptionDetailsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory AdoptionDetailsModel.fromJson(Map<String, dynamic> json) => AdoptionDetailsModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": response.toJson(),
  };
}

class Response {
  Response({
     this.idAdoption,
     this.petName,
     this.petStrain,
     this.petPicture,
     this.animalSubCategoryNameEn,
     this.clientPhone,
     this.clientName,
     this.clientEmail,
     this.clientPicture,
     this.petColor,
     this.petGender,
     this.petSize,
     this.petCondition,
     this.petDescription,
     this.adoptionStatus,
     this.cityName,
     this.animalSubCategoryName,
     this.petAgeYear,
     this.petAgeMonth,
     this.adoptionGallery,
     this.idCity,
     this.idCountry,
     this.idAnimalSubCategory,
  });

  final idAdoption;
  final petName;
  final petStrain;
  final petPicture;
  final idCity;
  final idCountry;
  final idAnimalSubCategory;
  final animalSubCategoryNameEn;
  final clientPhone;
  final clientName;
  final clientEmail;
  final clientPicture;
  final petColor;
  final petGender;
  final petSize;
  final petCondition;
  final petDescription;
  final adoptionStatus;
  final cityName;
  final animalSubCategoryName;
  final petAgeYear;
  final petAgeMonth;
  List<AdoptionGallery>? adoptionGallery;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAdoption: json["IDAdoption"],
    petName: json["PetName"],
    petStrain: json["PetStrain"],
    petPicture: json["PetPicture"],
    idCity: json["IDCity"],
    idCountry: json["IDCountry"],
    idAnimalSubCategory: json["IDAnimalSubCategory"],
    animalSubCategoryNameEn: json["AnimalSubCategoryNameEn"],
    clientPhone: json["ClientPhone"],
    clientName: json["ClientName"],
    clientEmail: json["ClientEmail"],
    clientPicture: json["ClientPicture"],
    petColor: json["PetColor"],
    petGender: json["PetGender"],
    petSize: json["PetSize"],
    petCondition: json["PetCondition"],
    petDescription: json["PetDescription"],
    adoptionStatus: json["AdoptionStatus"],
    cityName: json["CityName"],
    animalSubCategoryName: json["AnimalSubCategoryName"],
    petAgeYear: json["PetAgeYear"],
    petAgeMonth: json["PetAgeMonth"],
    adoptionGallery: List<AdoptionGallery>.from(json["AdoptionGallery"].map((x) => AdoptionGallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IDAdoption": idAdoption,
    "PetName": petName,
    "PetStrain": petStrain,
    "PetPicture": petPicture,
    "IDCity": idCity,
    "IDCountry": idCountry,
    "IDAnimalSubCategory": idAnimalSubCategory,
    "AnimalSubCategoryNameEn": animalSubCategoryNameEn,
    "ClientPhone": clientPhone,
    "ClientName": clientName,
    "ClientEmail": clientEmail,
    "ClientPicture": clientPicture,
    "PetColor": petColor,
    "PetGender": petGender,
    "PetSize": petSize,
    "PetCondition": petCondition,
    "PetDescription": petDescription,
    "AdoptionStatus": adoptionStatus,
    "CityName": cityName,
    "AnimalSubCategoryName": animalSubCategoryName,
    "PetAgeYear": petAgeYear,
    "PetAgeMonth": petAgeMonth,
    "AdoptionGallery": List<dynamic>.from(adoptionGallery!.map((x) => x.toJson())),
  };
}

class AdoptionGallery {
  AdoptionGallery({
    required this.idAdoptionGallery,
    required this.adoptionGalleryPath,
  });

  int idAdoptionGallery;
  String adoptionGalleryPath;

  factory AdoptionGallery.fromJson(Map<String, dynamic> json) => AdoptionGallery(
    idAdoptionGallery: json["IDAdoptionGallery"],
    adoptionGalleryPath: json["AdoptionGalleryPath"],
  );

  Map<String, dynamic> toJson() => {
    "IDAdoptionGallery": idAdoptionGallery,
    "AdoptionGalleryPath": adoptionGalleryPath,
  };
}
