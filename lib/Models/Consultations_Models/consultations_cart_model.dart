// To parse this JSON data, do
//
//     final consultationsCartModel = consultationsCartModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConsultationsCartModel consultationsCartModelFromJson(String str) =>
    ConsultationsCartModel.fromJson(json.decode(str));

String consultationsCartModelToJson(ConsultationsCartModel data) =>
    json.encode(data.toJson());

class ConsultationsCartModel {
  ConsultationsCartModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ConsultationsCartModel.fromJson(Map<String, dynamic> json) =>
      ConsultationsCartModel(
        success: json["Success"],
        apiMsg: json["ApiMsg"],
        apiCode: json["ApiCode"],
        response: List<Response>.from(
            json["Response"].map((x) => Response.fromJson(x))),
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
    required this.idConsult,
    this.consultDate,
    required this.consultStatus,
    required this.consultAmount,
    required this.doctorName,
    this.doctorPicture,
  });

  int idConsult;
  DateTime? consultDate;
  int consultAmount;
  String consultStatus;
  String doctorName;
  String? doctorPicture;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        idConsult: json["IDConsult"],
        consultDate: json["ConsultDate"] == null
            ? DateTime(0)
            : DateTime.parse(json["ConsultDate"]),
    consultAmount: json["ConsultAmount"],
        consultStatus: json["ConsultStatus"],
        doctorName: json["DoctorName"],
        doctorPicture: json["DoctorPicture"],
      );

  Map<String, dynamic> toJson() => {
        "IDConsult": idConsult,
        "ConsultDate": consultDate!.toIso8601String(),
        "ConsultAmount": consultAmount,
        "ConsultStatus": consultStatus,
        "DoctorName": doctorName,
        "DoctorPicture": doctorPicture,
      };
}
