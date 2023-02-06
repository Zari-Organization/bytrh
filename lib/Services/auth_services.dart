import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;
import '../Models/Auth_Models/login_model.dart';
import '../Models/Auth_Models/register_model.dart';
import '../Utils/app_constants.dart';

class AuthServices {
  Future<LoginModel> loginAPI(
      String UserName,
      String Password,
      String LoginBy,
      String ClientAppLanguage,
      String ClientDeviceType,
      String ClientMobileService,
      context) async {
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
      return LoginModel.fromJson(jsonData);
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

  Future<RegisterModel> registerAPI(
      String ClientEmail,
      String ClientPhone,
      String ClientPhoneFlag,
      String ClientPassword,
      String ClientName,
      String LoginBy,
      String ClientAppLanguage,
      String ClientDeviceType,
      String ClientMobileService,
      context) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'ClientEmail': ClientEmail,
      'ClientPhone': ClientPhone,
      'ClientPhoneFlag': ClientPhoneFlag,
      'ClientPassword': ClientPassword,
      'ClientName': ClientName,
      'LoginBy': LoginBy,
      'ClientAppLanguage': ClientAppLanguage,
      'ClientDeviceType': ClientDeviceType,
      'ClientMobileService': ClientMobileService,
    });

    var response = await dio.post(
      AppConstants.apiUrl + '/api/client' + '/register',
      data: formData,
      options: dioImport.Options(
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    var jsonData = response.data;
    if (jsonData['Success'] == true) {
      log("hello 1");
      log(jsonData.toString());
      return RegisterModel.fromJson(jsonData);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: Text(jsonData["ApiMsg"].toString()),
        ),
      );
      return throw Exception(jsonData["ApiMsg"].toString());
    }
  }
}
