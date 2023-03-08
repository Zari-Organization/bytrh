// To parse this JSON data, do
//
//     final animalProductCuttingModel = animalProductCuttingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnimalProductCuttingModel animalProductCuttingModelFromJson(String str) => AnimalProductCuttingModel.fromJson(json.decode(str));

String animalProductCuttingModelToJson(AnimalProductCuttingModel data) => json.encode(data.toJson());

class AnimalProductCuttingModel {
  AnimalProductCuttingModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AnimalProductCuttingModel.fromJson(Map<String, dynamic> json) => AnimalProductCuttingModel(
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
    required this.idCutting,
    required this.cuttingPrice,
    required this.cuttingName,
  });

  int idCutting;
  int cuttingPrice;
  String cuttingName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idCutting: json["IDCutting"],
    cuttingPrice: json["CuttingPrice"],
    cuttingName: json["CuttingName"],
  );

  Map<String, dynamic> toJson() => {
    "IDCutting": idCutting,
    "CuttingPrice": cuttingPrice,
    "CuttingName": cuttingName,
  };
}
