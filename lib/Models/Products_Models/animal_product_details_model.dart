// To parse this JSON data, do
//
//     final animalProductDetailsModel = animalProductDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnimalProductDetailsModel animalProductDetailsModelFromJson(String str) => AnimalProductDetailsModel.fromJson(json.decode(str));

String animalProductDetailsModelToJson(AnimalProductDetailsModel data) => json.encode(data.toJson());

class AnimalProductDetailsModel {
  AnimalProductDetailsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory AnimalProductDetailsModel.fromJson(Map<String, dynamic> json) => AnimalProductDetailsModel(
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
     this.idAnimalProduct,
     this.animalProductPrice,
     this.animalProductImage,
     this.animalProductGender,
     this.animalProductSize,
     this.animalProductAge,
     this.animalProductDescription,
     this.hasBagging,
     this.hasCutting,
     this.hasDelivery,
     this.allowPhone,
     this.allowWhatsapp,
     this.clientName,
     this.clientPicture,
     this.clientPhone,
     this.cityName,
     this.sameClient,
     this.gallery,
  });

  final idAnimalProduct;
  final animalProductPrice;
  final animalProductImage;
  final animalProductGender;
  final animalProductSize;
  final animalProductAge;
  final animalProductDescription;
  final hasBagging;
  final hasCutting;
  final hasDelivery;
  final allowPhone;
  final allowWhatsapp;
  final clientName;
  final clientPicture;
  final clientPhone;
  final cityName;
  final sameClient;
  List<Gallery>? gallery;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProduct: json["IDAnimalProduct"],
    animalProductPrice: json["AnimalProductPrice"],
    animalProductImage: json["AnimalProductImage"],
    animalProductGender: json["AnimalProductGender"],
    animalProductSize: json["AnimalProductSize"],
    animalProductAge: json["AnimalProductAge"],
    animalProductDescription: json["AnimalProductDescription"],
    hasBagging: json["HasBagging"],
    hasCutting: json["HasCutting"],
    hasDelivery: json["HasDelivery"],
    allowPhone: json["AllowPhone"],
    allowWhatsapp: json["AllowWhatsapp"],
    clientName: json["ClientName"],
    clientPicture: json["ClientPicture"],
    clientPhone: json["ClientPhone"],
    cityName: json["CityName"],
    sameClient: json["SameClient"],
    gallery: List<Gallery>.from(json["Gallery"].map((x) => Gallery.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProduct": idAnimalProduct,
    "AnimalProductPrice": animalProductPrice,
    "AnimalProductImage": animalProductImage,
    "AnimalProductGender": animalProductGender,
    "AnimalProductSize": animalProductSize,
    "AnimalProductAge": animalProductAge,
    "AnimalProductDescription": animalProductDescription,
    "HasBagging": hasBagging,
    "HasCutting": hasCutting,
    "HasDelivery": hasDelivery,
    "AllowPhone": allowPhone,
    "AllowWhatsapp": allowWhatsapp,
    "ClientName": clientName,
    "ClientPicture": clientPicture,
    "ClientPhone": clientPhone,
    "CityName": cityName,
    "SameClient": sameClient,
    "Gallery": List<dynamic>.from(gallery!.map((x) => x.toJson())),
  };
}

class Gallery {
  Gallery({
    required this.idAnimalProductGallery,
    required this.animalProductGalleryPath,
  });

  int idAnimalProductGallery;
  String animalProductGalleryPath;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    idAnimalProductGallery: json["IDAnimalProductGallery"],
    animalProductGalleryPath: json["AnimalProductGalleryPath"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProductGallery": idAnimalProductGallery,
    "AnimalProductGalleryPath": animalProductGalleryPath,
  };
}
