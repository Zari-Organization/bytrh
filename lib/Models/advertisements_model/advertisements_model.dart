// To parse this JSON data, do
//
//     final advertisementsModel = advertisementsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdvertisementsModel advertisementsModelFromJson(String str) => AdvertisementsModel.fromJson(json.decode(str));

String advertisementsModelToJson(AdvertisementsModel data) => json.encode(data.toJson());

class AdvertisementsModel {
  AdvertisementsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AdvertisementsModel.fromJson(Map<String, dynamic> json) => AdvertisementsModel(
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
    required this.idAdvertisement,
    required this.idLink,
    required this.idCity,
    required this.advertisementImage,
    required this.advertisementService,
    required this.advertisementStartDate,
    required this.advertisementEndDate,
    required this.advertisementLocation,
  });

  int idAdvertisement;
  dynamic idLink;
  dynamic idCity;
  String advertisementImage;
  String advertisementService;
  dynamic advertisementStartDate;
  dynamic advertisementEndDate;
  dynamic advertisementLocation;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAdvertisement: json["IDAdvertisement"],
    idLink: json["IDLink"],
    idCity: json["IDCity"],
    advertisementImage: json["AdvertisementImage"],
    advertisementService: json["AdvertisementService"],
    advertisementStartDate: json["AdvertisementStartDate"],
    advertisementEndDate: json["AdvertisementEndDate"],
    advertisementLocation: json["AdvertisementLocation"],
  );

  Map<String, dynamic> toJson() => {
    "IDAdvertisement": idAdvertisement,
    "IDLink": idLink,
    "IDCity": idCity,
    "AdvertisementImage": advertisementImage,
    "AdvertisementService": advertisementService,
    "AdvertisementStartDate": advertisementStartDate,
    "AdvertisementEndDate": advertisementEndDate,
    "AdvertisementLocation": advertisementLocation,
  };
}
