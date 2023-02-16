// To parse this JSON data, do
//
//     final areasModel = areasModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AreasModel areasModelFromJson(String str) => AreasModel.fromJson(json.decode(str));

String areasModelToJson(AreasModel data) => json.encode(data.toJson());

class AreasModel {
  AreasModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AreasModel.fromJson(Map<String, dynamic> json) => AreasModel(
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
    required this.idCity,
    required this.idArea,
    required this.areaName,
    required this.areaActive,
  });

  int idCity;
  int idArea;
  String areaName;
  int areaActive;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idCity: json["IDCity"],
    idArea: json["IDArea"],
    areaName: json["AreaName"],
    areaActive: json["AreaActive"],
  );

  Map<String, dynamic> toJson() => {
    "IDCity": idCity,
    "IDArea": idArea,
    "AreaName": areaName,
    "AreaActive": areaActive,
  };
}
