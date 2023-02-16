import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;

import '../../Models/Consultations_Models/animals_category_model.dart';
import '../../Models/Consultations_Models/consultations_cart_model.dart';
import '../../Models/Consultations_Models/consultations_doctor_profile_model.dart';
import '../../Models/Consultations_Models/consultations_doctor_reservation_time_model.dart';
import '../../Models/Consultations_Models/consultations_doctors_model.dart';
import '../../Models/Location_Models/areas_model.dart';
import '../../Models/Wallet_Models/my_wallet_model.dart';
import '../../Models/Wallet_Models/payment_methods_model.dart';
import '../../Models/Wallet_Models/wallet_payment_model.dart';
import '../../Utils/app_constants.dart';

class ConsultationsServices {
  static Future<ConsultationsDoctorsModel> getConsultationsDoctors(
  {
    required String service,
    required   String DoctorName,
    required  String IDArea,
    required  String IDAnimalCategory,
    required  String ClientLatitude,
    required  String ClientLongitude,
}
  ) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/doctors'),
      body: {
        'DoctorName': DoctorName,
        'IDArea': IDArea,
        'IDAnimalCategory': IDAnimalCategory,
        'ClientLatitude': ClientLatitude,
        'ClientLongitude': ClientLongitude,
        'Service': service,
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Consultations Doctors Api --> $decodedData");
      return consultationsDoctorsModelFromJson(jsonData);
    } else {
      return consultationsDoctorsModelFromJson(jsonData);
    }
  }

  static Future<ConsultationsDoctorProfileModel> getConsultationsDoctorProfile(
      String IDDoctor, String ServiceKey) async {
    var response = await http.post(
      Uri.parse(
          AppConstants.apiUrl + '/api/client' + '/consult/doctor/profile'),
      body: {
        'IDDoctor': IDDoctor,
        'Service': ServiceKey,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Consultations Doctor Profile Api --> $decodedData");
      return consultationsDoctorProfileModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }

  static Future<AreasModel> getAreA(String idCity) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client/' + 'areas/$idCity'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Areas Api --> $decodedData");
      return areasModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load Areas");
    }
  }

  static Future<AnimalsCategoryModel> getAnimalsCategory() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client/' + 'animalcategories'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Animals Category Api --> $decodedData");
      return animalsCategoryModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load Animals Category");
    }
  }

  static requestConsultation({
    required String IDDoctor,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/urgent/request'),
      body: {
        'IDDoctor': IDDoctor,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      log("Request Consultation Api --> $decodedData");
      return decodedData;
    }else {
      return decodedData;
    }
  }

  static Future<ConsultationsCartModel> getConsultationsCart(
      {
        required String ConsultType,
      }
      ) async {
      var response = await http.post(
        Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/list'),
        body: {
          'ConsultType': ConsultType,
          'ConsultStatus': "",
        },
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken
        },
      );
      var jsonData = response.body;
      var decodedData = jsonDecode(jsonData);
      log("Consultations Cart Api --> $decodedData");
      if (decodedData['Success']) {
        log("Consultations Cart Api --> $decodedData");
        return consultationsCartModelFromJson(jsonData);
      } else {
        return consultationsCartModelFromJson(jsonData);
      }

  }

  static Future<ConsultationsDoctorReservationTimeModel> getConsultationsDoctorReservationTime(
      {
        required String IDConsult,
      }
      ) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/urgent/time'),
      body: {
        'IDConsult': "1",
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Consultations Doctor Reservation Time Api --> $decodedData");
      return consultationsDoctorReservationTimeModelFromJson(jsonData);
    } else {
      return consultationsDoctorReservationTimeModelFromJson(jsonData);
    }

  }

  static selectConsultationTime({
    required String IDConsult,
    required String IDConsultTimeValue,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/urgent/time/select'),
      body: {
        'IDConsult': IDConsult,
        'IDConsultTimeValue': IDConsultTimeValue,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      log("Select Consultation Time Api --> $decodedData");
      return decodedData;
    }else {
      return decodedData;
    }
  }
}
