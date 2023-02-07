import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Utils/app_constants.dart';

class ChangePasswordServices {
  static changePassword(
      String OldPassword,
      String NewPassword,
      String PasswordConfirmation,
      ) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/password/change'),
      body: {
        'OldPassword': OldPassword,
        'NewPassword': NewPassword,
        'PasswordConfirmation': PasswordConfirmation,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      if (kDebugMode) {
        print("Edit Password Api Success --> $decodedData");
      }

      return decodedData;
    }else if(!decodedData["Success"]){
      if (kDebugMode) {
        print("Edit Password Api Error --> $decodedData");
      }
      return decodedData;
    } else {
      return throw Exception("Failed to change password");
    }
  }
}
