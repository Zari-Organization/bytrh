// To parse this JSON data, do
//
//     final termDoctorDaysModel = termDoctorDaysModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TermDoctorDaysModel termDoctorDaysModelFromJson(String str) => TermDoctorDaysModel.fromJson(json.decode(str));

String termDoctorDaysModelToJson(TermDoctorDaysModel data) => json.encode(data.toJson());

class TermDoctorDaysModel {
  TermDoctorDaysModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory TermDoctorDaysModel.fromJson(Map<String, dynamic> json) => TermDoctorDaysModel(
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
    required this.idDoctorHour,
    required this.doctorStartHour,
  });

  int idDoctorHour;
  String doctorStartHour;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idDoctorHour: json["IDDoctorHour"],
    doctorStartHour: json["DoctorStartHour"],
  );

  Map<String, dynamic> toJson() => {
    "IDDoctorHour": idDoctorHour,
    "DoctorStartHour": doctorStartHour,
  };
}
