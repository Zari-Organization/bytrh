// To parse this JSON data, do
//
//     final walletPaymentModel = walletPaymentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

WalletPaymentModel walletPaymentModelFromJson(String str) => WalletPaymentModel.fromJson(json.decode(str));

String walletPaymentModelToJson(WalletPaymentModel data) => json.encode(data.toJson());

class WalletPaymentModel {
  WalletPaymentModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory WalletPaymentModel.fromJson(Map<String, dynamic> json) => WalletPaymentModel(
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
     this.invoiceId,
     this.paymentUrl,
  });

  final invoiceId;
  final paymentUrl;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    invoiceId: json["InvoiceId"],
    paymentUrl: json["PaymentURL"],
  );

  Map<String, dynamic> toJson() => {
    "InvoiceId": invoiceId,
    "PaymentURL": paymentUrl,
  };
}
