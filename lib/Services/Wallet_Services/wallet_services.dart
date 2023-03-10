import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;

import '../../Models/Wallet_Models/my_wallet_model.dart';
import '../../Models/Wallet_Models/payment_methods_model.dart';
import '../../Models/Wallet_Models/wallet_payment_model.dart';
import '../../Utils/app_constants.dart';

class WalletServices {
  static Future<MyWalletModel> getMyWallet() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/wallet'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] == true) {
      log("My Wallet Api --> $decodedData");
      return myWalletModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }

  static Future<PaymentMethodsModel> getPaymentMethods() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/payment/methods'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    log("Payment Methods Api --> $decodedData");
    if (decodedData['Success'] == true) {
      log("Payment Methods Api --> $decodedData");

      return paymentMethodsModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }
  static Future<WalletPaymentModel> getWalletPayment(String Amount, String IDPaymentMethod) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/payment/initiate'),
      body: {
        'Amount': Amount,
        'IDPaymentMethod': IDPaymentMethod,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] == true) {
      log("Wallet Payment Api --> $decodedData");

      return walletPaymentModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }

  static Future walletPaymentStatus(String InvoiceId) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/payment/callback?InvoiceId=$InvoiceId'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (kDebugMode) {
      print(
        "Wallet Payment Status --> $decodedData",
      );
    }
    if (decodedData["Success"]) {
      if (kDebugMode) {
        print(
          "Wallet Payment Status --> $decodedData",
        );
      }
      return decodedData;
    } else {
      return decodedData;
    }
  }

}
