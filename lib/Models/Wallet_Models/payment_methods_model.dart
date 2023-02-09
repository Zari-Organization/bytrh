// To parse this JSON data, do
//
//     final paymentMethodsModel = paymentMethodsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PaymentMethodsModel paymentMethodsModelFromJson(String str) => PaymentMethodsModel.fromJson(json.decode(str));

String paymentMethodsModelToJson(PaymentMethodsModel data) => json.encode(data.toJson());

class PaymentMethodsModel {
  PaymentMethodsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) => PaymentMethodsModel(
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
    required this.idPaymentMethod,
    required this.paymentMethod,
  });

  int idPaymentMethod;
  String paymentMethod;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idPaymentMethod: json["IDPaymentMethod"],
    paymentMethod: json["PaymentMethod"],
  );

  Map<String, dynamic> toJson() => {
    "IDPaymentMethod": idPaymentMethod,
    "PaymentMethod": paymentMethod,
  };
}
