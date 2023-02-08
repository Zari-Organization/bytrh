import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Logic/Controllers/verification_controller.dart';
import '../Utils/app_constants.dart';

class VerificationServices {
  static getVerificationCode() async {
    var response = await http.get(
      Uri.parse("${AppConstants.apiUrl}public/api/manager/verify/resend"),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["success"]) {
      if (kDebugMode) {
        print("Verification code Api --> $jsonData");
      }

      return decodedData;
    } else {
      return throw Exception("Failed to load verification code");
    }
  }

  confirmCode(String code) async {

      var data = await http.post(
        Uri.parse(AppConstants.apiUrl + 'public/api/manager/verify'),
        body: {
          'UserVerificationCode': code,
        },
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken,
        },
      );
      var jsonData = json.decode(data.body);
      var decodedData = jsonDecode(data.body);
      if (decodedData['Success'] == true) {
        if (kDebugMode) {
          print(decodedData);
        }
        return decodedData;
      } else {
        return decodedData;
      }

  }

  confirmCodeToResetPass(
    String userPhone,
    String code,
  ) async {
      var data = await http.post(
        Uri.parse(AppConstants.apiUrl + '/api/client' + '/verify/code'),
        body: {
          'ClientPhone': userPhone,
          'VerificationCode': code,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      var jsonData = json.decode(data.body);
      var decodedData = jsonDecode(data.body);
      log(decodedData.toString());
      if (decodedData['Success'] == true) {
        if (kDebugMode) {
          print(decodedData);
        }
        return decodedData;
      } else {
        return decodedData;
      }

  }

  sendCodeToResetPassword(String userPhone) async {

      var data = await http.post(
        Uri.parse(AppConstants.apiUrl + '/api/client' + '/password/forget'),
        body: {
          'ClientPhone': userPhone,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      var jsonData = json.decode(data.body);
      var decodedData = jsonDecode(data.body);
      if (decodedData['Success'] == true) {
        if (kDebugMode) {
          print(decodedData);
        }
        return decodedData;
      } else {
        return decodedData;
      }

  }

  changePassword(
    String UserPhone,
    String UserPassword,
    String PasswordConfirmation,
  ) async {

      var response = await http.post(
        Uri.parse(AppConstants.apiUrl + '/api/client' + '/password/forget/change'),
        body: {
          'ClientPhone': UserPhone,
          'NewPassword': UserPassword,
          'PasswordConfirmation': PasswordConfirmation,
        },
        headers: {
          'Accept': 'application/json',
        },
      );
      var jsonData = response.body;
      var decodedData = jsonDecode(jsonData);
      if (kDebugMode) {
        print("Edit User Info Api --> $decodedData");
      }
      if (decodedData["Success"]) {
        if (kDebugMode) {
          print("Edit User Info Api --> $jsonData");
        }
        return decodedData;
      } else {
        return throw Exception("Failed to change password");
      }

  }
}
