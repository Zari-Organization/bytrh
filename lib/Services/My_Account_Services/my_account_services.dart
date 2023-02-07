import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Utils/app_constants.dart';

class MyAccountServices {
  static logout() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/logout'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      if (kDebugMode) {
        print("Logout Api Success --> $decodedData");
      }

      return decodedData;
    }else if(!decodedData["Success"]){
      if (kDebugMode) {
        print("Logout Api Error --> $decodedData");
      }
      return decodedData;
    } else {
      return throw Exception("Failed to Logout");
    }
  }
}
