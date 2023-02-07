
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../Models/personal_data_model.dart';
import '../../Utils/app_constants.dart';

class PersonalDataServices {

  static Future<PersonalDataModel> getPersonalData() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/profile'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      if (kDebugMode) {
        print("Personal Data Api --> $decodedData");
      }

      return personalDataModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }
}
