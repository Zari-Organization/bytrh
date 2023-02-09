// To parse this JSON data, do
//
//     final myWalletModel = myWalletModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyWalletModel myWalletModelFromJson(String str) => MyWalletModel.fromJson(json.decode(str));

String myWalletModelToJson(MyWalletModel data) => json.encode(data.toJson());

class MyWalletModel {
  MyWalletModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory MyWalletModel.fromJson(Map<String, dynamic> json) => MyWalletModel(
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
     this.clientName,
     this.clientBalance,
     this.clientCurrentPoints,
     this.giftCards,
  });

  final clientName;
  final clientBalance;
  final clientCurrentPoints;
  final giftCards;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    clientName: json["ClientName"],
    clientBalance: json["ClientBalance"],
    clientCurrentPoints: json["ClientCurrentPoints"],
    giftCards: json["GiftCards"],
  );

  Map<String, dynamic> toJson() => {
    "ClientName": clientName,
    "ClientBalance": clientBalance,
    "ClientCurrentPoints": clientCurrentPoints,
    "GiftCards": giftCards,
  };
}
