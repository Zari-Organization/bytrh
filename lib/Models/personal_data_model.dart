// To parse this JSON data, do
//
//     final personalDataModel = personalDataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PersonalDataModel personalDataModelFromJson(String str) => PersonalDataModel.fromJson(json.decode(str));

String personalDataModelToJson(PersonalDataModel data) => json.encode(data.toJson());

class PersonalDataModel {
  PersonalDataModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  PersonalDataResponse response;

  factory PersonalDataModel.fromJson(Map<String, dynamic> json) => PersonalDataModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: PersonalDataResponse.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": response.toJson(),
  };
}

class PersonalDataResponse {
  PersonalDataResponse({
     this.idClient,
     this.clientPhone,
     this.clientPhoneFlag,
     this.clientName,
     this.clientEmail,
     this.clientPicture,
     this.iDCountry,
     this.idCity,
     this.clientStatus,
     this.accessToken,
     this.countryName,
     this.cityName,
     this.idAnimalCategory,
  });

  final idClient;
  final clientPhone;
  final clientPhoneFlag;
  final clientName;
  final clientEmail;
  final clientPicture;
  final countryName;
  final cityName;
  final iDCountry;
  final idCity;
  final clientStatus;
  final accessToken;
  final idAnimalCategory;

  factory PersonalDataResponse.fromJson(Map<String, dynamic> json) => PersonalDataResponse(
    idClient: json["IDClient"],
    clientPhone: json["ClientPhone"],
    clientPhoneFlag: json["ClientPhoneFlag"],
    clientName: json["ClientName"],
    clientEmail: json["ClientEmail"],
    clientPicture: json["ClientPicture"],
    iDCountry: json["IDCountry"],
    idCity: json["IDCity"],
    countryName: json["CountryName"],
    cityName: json["CityName"],
    clientStatus: json["ClientStatus"],
    accessToken: json["AccessToken"],
    idAnimalCategory: json["IDAnimalCategory"],
  );

  Map<String, dynamic> toJson() => {
    "IDClient": idClient,
    "ClientPhone": clientPhone,
    "ClientPhoneFlag": clientPhoneFlag,
    "ClientName": clientName,
    "ClientEmail": clientEmail,
    "ClientPicture": clientPicture,
    "CountryName": countryName,
    "CityName": cityName,
    "IDCountry": iDCountry,
    "IDCity": idCity,
    "ClientStatus": clientStatus,
    "AccessToken": accessToken,
    "IDAnimalCategory": idAnimalCategory,
  };
}
