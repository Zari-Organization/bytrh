// To parse this JSON data, do
//
//     final ourNewHomeModel = ourNewHomeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OurNewHomeModel ourNewHomeModelFromJson(String str) => OurNewHomeModel.fromJson(json.decode(str));

String ourNewHomeModelToJson(OurNewHomeModel data) => json.encode(data.toJson());

class OurNewHomeModel {
  OurNewHomeModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory OurNewHomeModel.fromJson(Map<String, dynamic> json) => OurNewHomeModel(
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
    required this.petPicture,
    required this.petName,
    required this.petStrain,
  });

  int idAdoption;
  String petPicture;
  String petName;
  String petStrain;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAdoption: json["IDAdoption"],
    petPicture: json["PetPicture"],
    petName: json["PetName"],
    petStrain: json["PetStrain"],
  );

  Map<String, dynamic> toJson() => {
    "IDAdoption": idAdoption,
    "PetPicture": petPicture,
    "PetName": petName,
    "PetStrain": petStrain,
  };
}
