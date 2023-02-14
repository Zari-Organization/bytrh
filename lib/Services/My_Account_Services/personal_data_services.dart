
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;
import '../../Logic/controllers/My_Account_Controllers/personal_data_controller.dart';
import '../../Logic/controllers/verification_controller.dart';
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
      log("Personal Data Api --> $decodedData");
      return personalDataModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }

  static editClientInfo(
      String ClientName,
      String ClientEmail,
      String ClientPhone,
      String ClientPhoneFlag,
      String IDCity,
      File? ClientPicture,
      context,
      ) async {
    final personalDataController = Get.find<PersonalDataController>();

    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'ClientName': ClientName,
      'ClientEmail': ClientEmail,
      'ClientPhone': ClientPhone,
      'ClientPhoneFlag': ClientPhoneFlag,
      'IDCity': IDCity,
      "ClientPicture": personalDataController
          .profileImageFile.value!.path.isNotEmpty?await dioImport.MultipartFile.fromFile("${ClientPicture!.path}",
          filename: "${ClientPicture.path.split('/').last}"):ClientPicture,

    });
    var response = await dio.post(
      AppConstants.apiUrl + '/api/client' + '/profile/update',
      data: formData,
      options: dioImport.Options(
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken
        },
      ),
    );
    var jsonData = response.data;
    log("Edit User Info Api --> $jsonData");
    if (jsonData["Success"]) {
      return jsonData;
    } else {
      return jsonData;
    }
  }
  static Future<List> getCountriesFlags() async {
    var response = await http.get(
      Uri.parse("https://nader15.github.io/countries_list/countries.json"),
    );
    var jsonData = response.body;
    List decodedData = jsonDecode(jsonData);
    if (decodedData.isNotEmpty) {
      log("Countries Flags Api --> $decodedData");
      return decodedData;
    } else {
      return [];
    }
  }
}
