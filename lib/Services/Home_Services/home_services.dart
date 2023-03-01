import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../Models/Home_Models/our_new_home_model.dart';
import '../../Models/advertisements_model/advertisements_model.dart';
import '../../Utils/app_constants.dart';

class HomeServices {
  static Future<OurNewHomeModel> getOurNew() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/home'),
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] == true) {
      log("Our New Api --> $decodedData");
      return ourNewHomeModelFromJson(jsonData);
    } else {
      log("Our New Api --> $decodedData");
      return ourNewHomeModelFromJson(jsonData);
    }
  }
}
