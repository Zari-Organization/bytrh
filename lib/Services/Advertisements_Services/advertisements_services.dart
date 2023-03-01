import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../Models/advertisements_model/advertisements_model.dart';
import '../../Utils/app_constants.dart';

class AdvertisementsServices {
  static Future<AdvertisementsModel> getAdvertisements({
    required String AdvertisementLocation,
    required String AdvertisementService,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/advertisements'),
      body: {
        "AdvertisementLocation": AdvertisementLocation,
        "AdvertisementService": AdvertisementService
      },
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] == true) {
      log("Advertisements Api --> $decodedData");
      return advertisementsModelFromJson(jsonData);
    } else {
      log("Advertisements Api --> $decodedData");
      return advertisementsModelFromJson(jsonData);
    }
  }
}
