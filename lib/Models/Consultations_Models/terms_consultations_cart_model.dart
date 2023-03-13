// To parse this JSON data, do
//
//     final termsConsultationsCartModel = termsConsultationsCartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TermsConsultationsCartModel termsConsultationsCartModelFromJson(String str) => TermsConsultationsCartModel.fromJson(json.decode(str));

String termsConsultationsCartModelToJson(TermsConsultationsCartModel data) => json.encode(data.toJson());

class TermsConsultationsCartModel {
  TermsConsultationsCartModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory TermsConsultationsCartModel.fromJson(Map<String, dynamic> json) => TermsConsultationsCartModel(
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
    required this.idConsultCart,
    required this.consultAmount,
    required this.doctorHourDay,
    required this.consultDate,
    required this.doctorName,
    required this.doctorPicture,
  });

  int idConsultCart;
  int consultAmount;
  String doctorHourDay;
  DateTime consultDate;
  String doctorName;
  String doctorPicture;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idConsultCart: json["IDConsultCart"],
    consultAmount: json["ConsultAmount"],
    doctorHourDay: json["DoctorHourDay"],
    consultDate: DateTime.parse(json["ConsultDate"]),
    doctorName: json["DoctorName"],
    doctorPicture: json["DoctorPicture"],
  );

  Map<String, dynamic> toJson() => {
    "IDConsultCart": idConsultCart,
    "ConsultAmount": consultAmount,
    "DoctorHourDay": doctorHourDay,
    "ConsultDate": "${consultDate.year.toString().padLeft(4, '0')}-${consultDate.month.toString().padLeft(2, '0')}-${consultDate.day.toString().padLeft(2, '0')}",
    "DoctorName": doctorName,
    "DoctorPicture": doctorPicture,
  };
}
