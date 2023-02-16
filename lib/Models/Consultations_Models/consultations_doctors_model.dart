// To parse this JSON data, do
//
//     final consultationsDoctorsModel = consultationsDoctorsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConsultationsDoctorsModel consultationsDoctorsModelFromJson(String str) => ConsultationsDoctorsModel.fromJson(json.decode(str));

String consultationsDoctorsModelToJson(ConsultationsDoctorsModel data) => json.encode(data.toJson());

class ConsultationsDoctorsModel {
  ConsultationsDoctorsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ConsultationsDoctorsModel.fromJson(Map<String, dynamic> json) => ConsultationsDoctorsModel(
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
    required this.idDoctor,
    required this.doctorName,
    required this.doctorPicture,
    required this.doctorPricing,
  });

  int idDoctor;
  String doctorName;
  String doctorPicture;
  int doctorPricing;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idDoctor: json["IDDoctor"],
    doctorName: json["DoctorName"],
    doctorPicture: json["DoctorPicture"],
    doctorPricing: json["DoctorPricing"],
  );

  Map<String, dynamic> toJson() => {
    "IDDoctor": idDoctor,
    "DoctorName": doctorName,
    "DoctorPicture": doctorPicture,
    "DoctorPricing": doctorPricing,
  };
}
