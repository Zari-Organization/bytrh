import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/auth_model.dart';
import '../Utils/app_constants.dart';

class AuthServices {
  Future<AuthModel> loginAPI(String UserName, String Password, String LoginBy,String ClientAppLanguage, String ClientDeviceType, String ClientMobileService,context) async {
    var data = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/login'),
      body: {
        'UserName': UserName,
        'Password': Password,
        'LoginBy': LoginBy,
        'ClientAppLanguage': ClientAppLanguage,
        'ClientDeviceType': ClientDeviceType,
        'ClientMobileService': ClientMobileService,
      },
    );
    var jsonData = json.decode(data.body);
    var decodedData = jsonDecode(data.body);
    if (decodedData['Success'] == true) {
      if (kDebugMode) {
        print(decodedData);
      }
      return AuthModel.fromJson(jsonData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(decodedData["ApiMsg"].toString()),
        ),
      );
      return throw Exception(decodedData["ApiMsg"].toString());
    }
  }

}
