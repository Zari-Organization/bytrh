// To parse this JSON data, do
//
//     final animalProductBaggingModel = animalProductBaggingModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AnimalProductBaggingModel animalProductBaggingModelFromJson(String str) => AnimalProductBaggingModel.fromJson(json.decode(str));

String animalProductBaggingModelToJson(AnimalProductBaggingModel data) => json.encode(data.toJson());

class AnimalProductBaggingModel {
  AnimalProductBaggingModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AnimalProductBaggingModel.fromJson(Map<String, dynamic> json) => AnimalProductBaggingModel(
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
    required this.idBagging,
    required this.baggingPrice,
    required this.baggingName,
  });

  int idBagging;
  int baggingPrice;
  String baggingName;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idBagging: json["IDBagging"],
    baggingPrice: json["BaggingPrice"],
    baggingName: json["BaggingName"],
  );

  Map<String, dynamic> toJson() => {
    "IDBagging": idBagging,
    "BaggingPrice": baggingPrice,
    "BaggingName": baggingName,
  };
}
