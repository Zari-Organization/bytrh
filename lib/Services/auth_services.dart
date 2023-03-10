import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;
import '../Logic/controllers/verification_controller.dart';
import '../Models/Auth_Models/login_model.dart';
import '../Models/Auth_Models/register_model.dart';
import '../Models/Location_Models/cities_model.dart';
import '../Models/Location_Models/countries_model.dart';
import '../Routes/routes.dart';
import '../Utils/app_constants.dart';

class AuthServices {
  Future<LoginModel> loginAPI(
      String UserName,
      String Password,
      String LoginBy,
      String ClientAppLanguage,
      String ClientDeviceType,
      String ClientMobileService,
      String ClientDeviceToken,
      context) async {
    final verificationController = Get.find<VerificationController>();
    var data = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/login'),
      body: {
        'UserName': UserName,
        'Password': Password,
        'LoginBy': LoginBy,
        'ClientAppLanguage': ClientAppLanguage,
        'ClientDeviceType': ClientDeviceType,
        'ClientMobileService': ClientMobileService,
        'ClientDeviceToken': ClientDeviceToken,
      },
    );
    var jsonData = json.decode(data.body);
    var decodedData = jsonDecode(data.body);
    log(decodedData.toString());
    if (decodedData['Success'] == true) {
      // if (kDebugMode) {
      //   log(decodedData);
      // }
      return LoginModel.fromJson(jsonData);
    } else {
      if (decodedData['ApiCode'] == 18) {
        verificationController.phoneController.value.text = UserName;
        verificationController.verifyLogin.value =true;
        verificationController.sendCodeToVerifyAccount(
            verificationController.phoneController.value.text,
            context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(decodedData["ApiMsg"].toString()),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(decodedData["ApiMsg"].toString()),
          ),
        );
        final _googleSignIn = GoogleSignIn();
        _googleSignIn.disconnect();
      }
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
      String IDCity,
      String IDAnimalCategory,
      context) async {
    final verificationController = Get.find<VerificationController>();
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
      'IDCity': IDCity,
      'IDAnimalCategory': IDAnimalCategory,
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
    log("service --> ${jsonData.toString()}");
    if (jsonData['Success'] == true) {
      verificationController.verifyLogin.value =false;
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

  static  getTerms() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/terms'),
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Terms Api --> $decodedData");

      return decodedData;
    } else {
      return decodedData;
    }
  }
  static Future<CountriesModel> getCountries() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/countries'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Countries Api --> $decodedData");
      return countriesModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load Countries");
    }
  }
  static Future<CitiesModel> getCities(String idCountry) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/cities/$idCountry'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Cities Api --> $decodedData");
      return citiesModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load Cities");
    }
  }
  static Future getLocation() async {
    var response = await http.get(
      Uri.parse("http://ip-api.com/json"),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['status']=="success") {
      log("Location Api --> $decodedData");
      return decodedData;
    } else {
      return decodedData;
    }
  }

}
