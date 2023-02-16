// To parse this JSON data, do
//
//     final consultationsDoctorProfileModel = consultationsDoctorProfileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConsultationsDoctorProfileModel consultationsDoctorProfileModelFromJson(String str) => ConsultationsDoctorProfileModel.fromJson(json.decode(str));

String consultationsDoctorProfileModelToJson(ConsultationsDoctorProfileModel data) => json.encode(data.toJson());

class ConsultationsDoctorProfileModel {
  ConsultationsDoctorProfileModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory ConsultationsDoctorProfileModel.fromJson(Map<String, dynamic> json) => ConsultationsDoctorProfileModel(
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
     this.idDoctor,
     this.doctorName,
     this.doctorPicture,
     this.doctorPricing,
     this.doctorBiography,
     this.location,
  });

  final idDoctor;
  final doctorName;
  final doctorPicture;
  final doctorPricing;
  final doctorBiography;
  final location;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idDoctor: json["IDDoctor"],
    doctorName: json["DoctorName"],
    doctorPicture: json["DoctorPicture"],
    doctorPricing: json["DoctorPricing"],
    doctorBiography: json["DoctorBiography"],
    location: json["Location"],
  );

  Map<String, dynamic> toJson() => {
    "IDDoctor": idDoctor,
    "DoctorName": doctorName,
    "DoctorPicture": doctorPicture,
    "DoctorPricing": doctorPricing,
    "DoctorBiography": doctorBiography,
    "Location": location,
  };
}
