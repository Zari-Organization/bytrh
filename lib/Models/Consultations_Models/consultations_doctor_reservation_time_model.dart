// To parse this JSON data, do
//
//     final consultationsDoctorReservationTimeModel = consultationsDoctorReservationTimeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConsultationsDoctorReservationTimeModel
    consultationsDoctorReservationTimeModelFromJson(String str) =>
        ConsultationsDoctorReservationTimeModel.fromJson(json.decode(str));

String consultationsDoctorReservationTimeModelToJson(
        ConsultationsDoctorReservationTimeModel data) =>
    json.encode(data.toJson());

class ConsultationsDoctorReservationTimeModel {
  ConsultationsDoctorReservationTimeModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory ConsultationsDoctorReservationTimeModel.fromJson(
          Map<String, dynamic> json) =>
      ConsultationsDoctorReservationTimeModel(
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
    this.consultTime,
  });

  final idDoctor;
  final doctorName;
  final doctorPicture;
  final doctorPricing;
  final doctorBiography;
  final location;
  List<ConsultTime>? consultTime;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        idDoctor: json["IDDoctor"],
        doctorName: json["DoctorName"],
        doctorPicture: json["DoctorPicture"],
        doctorPricing: json["DoctorPricing"],
        doctorBiography: json["DoctorBiography"],
        location: json["Location"],
        consultTime: List<ConsultTime>.from(
            json["ConsultTime"].map((x) => ConsultTime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "IDDoctor": idDoctor,
        "DoctorName": doctorName,
        "DoctorPicture": doctorPicture,
        "DoctorPricing": doctorPricing,
        "DoctorBiography": doctorBiography,
        "Location": location,
        "ConsultTime": List<dynamic>.from(consultTime!.map((x) => x.toJson())),
      };
}

class ConsultTime {
  ConsultTime({
    required this.idConsultTimeValue,
    required this.consultTimeValue,
  });

  int idConsultTimeValue;
  int consultTimeValue;

  factory ConsultTime.fromJson(Map<String, dynamic> json) => ConsultTime(
        idConsultTimeValue: json["IDConsultTimeValue"],
        consultTimeValue: json["ConsultTimeValue"],
      );

  Map<String, dynamic> toJson() => {
        "IDConsultTimeValue": idConsultTimeValue,
        "ConsultTimeValue": consultTimeValue,
      };
}
