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
import '../../Models/Consultations_Models/term_doctor_days_model.dart';
import '../../Models/Location_Models/areas_model.dart';
import '../../Models/Wallet_Models/my_wallet_model.dart';
import '../../Models/Wallet_Models/payment_methods_model.dart';
import '../../Models/Wallet_Models/wallet_payment_model.dart';
import '../../Utils/app_constants.dart';

class ConsultationsServices {
  static Future<ConsultationsDoctorsModel> getConsultationsDoctors({
    required String service,
    required String DoctorName,
    required String IDArea,
    required String IDAnimalCategory,
    required String ClientLatitude,
    required String ClientLongitude,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/doctors'),
      body: {
        'DoctorName': DoctorName,
        'IDArea': IDArea,
        // 'IDAnimalCategory': '',
        'IDAnimalCategory': IDAnimalCategory,
        'ClientLatitude': ClientLatitude,
        'ClientLongitude': ClientLongitude,
        'Service': service,
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      service=="URGENT_CONSULT"? log("Instant Consultations Doctors Api --> $decodedData"):log("Term Consultations Doctors Api --> $decodedData");
      return consultationsDoctorsModelFromJson(jsonData);
    } else {
      return consultationsDoctorsModelFromJson(jsonData);
    }
  }

  static Future<TermDoctorDaysModel> getConsultationsDoctorsDays({
    required String IDDoctor,
    required String Day,
    required String Date,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/doctor/appointments'),
      body: {
        'IDDoctor': IDDoctor,
        'Day': Day,
        'ConsultDate': Date,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Consultations Doctors Days Api --> $decodedData");
     return termDoctorDaysModelFromJson(jsonData);
    } else {
      return termDoctorDaysModelFromJson(jsonData);
    }
  }

  static Future<ConsultationsDoctorProfileModel> getConsultationsDoctorProfile(
      String IDDoctor, String ServiceKey, String IDConsult) async {
    try {
      var response = await http.post(
        Uri.parse(
            AppConstants.apiUrl + '/api/client' + '/consult/doctor/profile'),
        body: {
          'IDDoctor': IDDoctor,
          'Service': ServiceKey,
          'IDConsult': IDConsult,
        },
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken
        },
      );
      var jsonData = response.body;
      var decodedData = jsonDecode(jsonData);
      log("Consultations Doctor Profile Api --> $decodedData");
      if (decodedData['Success']) {
        log("Consultations Doctor Profile Api --> $decodedData");
        return consultationsDoctorProfileModelFromJson(jsonData);
      }
    } catch (e) {
      log(e.toString());
    }
    return throw Exception("Error");
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
      log("Animals Category Api --> $decodedData");
      return animalsCategoryModelFromJson(jsonData);
    }
  }

  static requestConsultation({
    required String IDDoctor,
  }) async {
    var response = await http.post(
      Uri.parse(
          AppConstants.apiUrl + '/api/client' + '/consult/urgent/request'),
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
    } else {
      return decodedData;
    }
  }

  static Future<ConsultationsCartModel> getConsultationsCart({
    required String ConsultType,
  }) async {
  try{
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
    if (decodedData['Success']) {
      log("Consultations Cart Api --> $decodedData");
      return consultationsCartModelFromJson(jsonData);
    } else {
      return consultationsCartModelFromJson(jsonData);
    }
  }catch(e){
    log(e.toString());
  }
  return throw Exception("Failed");
  }

  static Future<ConsultationsDoctorReservationTimeModel>
      getConsultationsDoctorReservationTime({
    required String IDConsult,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/urgent/time'),
      body: {
        'IDConsult': IDConsult,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    log("Consultations Doctor Reservation Time Api --> $decodedData");
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
    } else {
      return decodedData;
    }
  }

  termRequestConsult(
      dynamic DoctorList,
      ) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'DoctorList[]': DoctorList,
    });
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/consult/request',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      if (jsonData['Success']) {
        log("Request Consult Api --> $jsonData");
        return jsonData;
      } else {
        log("Request Consult Api --> $jsonData");
        return jsonData;
      }
  }
  static selectDoctorConsultationTime({
    required String IDConsult,
    required String IDDoctorHour,
    required String ConsultDate,
  }) async {
    var response = await http.post(
      Uri.parse(
          AppConstants.apiUrl + '/api/client' + '/consult/time/select'),
      body: {
        'IDConsult': IDConsult,
        'IDDoctorHour': IDDoctorHour,
        'ConsultDate': ConsultDate,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    log("Select Doctor Consultation Time Api --> $decodedData");
    log("IDConsult --> $IDConsult");
    log("IDDoctorHour --> $IDDoctorHour");
    log("ConsultDate --> $ConsultDate");
    if (decodedData["Success"]) {
      log("Select Doctor Consultation Time Api --> $decodedData");
      return decodedData;
    } else {
      return decodedData;
    }
  }
}
