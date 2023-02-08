// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  RegisterModel({
     this.success,
     this.apiMsg,
     this.apiCode,
     this.response,
  });

  final success;
  final apiMsg;
  final apiCode;
  Response? response;

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": response!.toJson(),
  };
}

class Response {
  Response({
    required this.idClient,
    required this.clientPhone,
    required this.clientPhoneFlag,
    required this.clientName,
    required this.clientEmail,
    required this.clientPicture,
    required this.idCity,
    required this.clientStatus,
    required this.accessToken,
  });

  int idClient;
  String clientPhone;
  String clientPhoneFlag;
  String clientName;
  String clientEmail;
  String clientPicture;
  dynamic idCity;
  String clientStatus;
  String accessToken;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idClient: json["IDClient"],
    clientPhone: json["ClientPhone"],
    clientPhoneFlag: json["ClientPhoneFlag"],
    clientName: json["ClientName"],
    clientEmail: json["ClientEmail"],
    clientPicture: json["ClientPicture"],
    idCity: json["IDCity"],
    clientStatus: json["ClientStatus"],
    accessToken: json["AccessToken"],
  );

  Map<String, dynamic> toJson() => {
    "IDClient": idClient,
    "ClientPhone": clientPhone,
    "ClientPhoneFlag": clientPhoneFlag,
    "ClientName": clientName,
    "ClientEmail": clientEmail,
    "ClientPicture": clientPicture,
    "IDCity": idCity,
    "ClientStatus": clientStatus,
    "AccessToken": accessToken,
  };
}
