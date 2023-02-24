import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;
import 'package:image_picker/image_picker.dart';

import '../../Models/Adoptions_Models/adoption_animals_categories_model.dart';
import '../../Models/Adoptions_Models/adoption_details_model.dart';
import '../../Models/Adoptions_Models/adoption_list_model.dart';
import '../../Utils/app_constants.dart';

class AdoptionsServices {
  static Future<AdoptionsListModel> getAdoptionsList(String AdoptionStatus) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/adoption'),
      body: {
        'AdoptionStatus': AdoptionStatus,
        // 'AdoptionStatus': "HISTORY",
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Adoptions List Api --> $decodedData");
      return adoptionsListModelFromJson(jsonData);
    } else {
      return adoptionsListModelFromJson(jsonData);
    }
  }

  static Future<AdoptionDetailsModel> getAdoptionDetails(
      String idAdoption) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl +
          '/api/client' +
          '/adoption/details/$idAdoption'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Adoption Details Api --> $decodedData");
      return adoptionDetailsModelFromJson(jsonData);
    } else {
      log("Adoption Details Api --> $decodedData");
      return adoptionDetailsModelFromJson(jsonData);
    }
  }

  static Future<AdoptionAnimalsCategoriesModel>
      getAdoptionAnimalsCategory() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client/' + 'animalsubcategories/1'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    log("Adoption Animals Category Api --> $decodedData");
    if (decodedData['Success']) {
      log("Adoption Animals Category Api --> $decodedData");
      return adoptionAnimalsCategoriesModelFromJson(jsonData);
    } else {
      return throw Exception("Failed to load Adoption Animals Category");
    }
  }

  addAdoptionAnimal({
      required String IDAnimalSubCategory,
      required String IDCity,
      required String PetName,
      required String PetStrain,
      required String PetColor,
      required String PetGender,
      required String PetAgeMonth,
      required String PetAgeYear,
      String? PetSize,
      String? PetCondition,
      String? PetDescription,
      required String AdoptionContact,
      required File PetPicture,
      List<XFile>? AdoptionGalleryList,
      context}) async {
    dioImport.Dio dio = dioImport.Dio();
    List<dynamic>? gallery = [];
    for (int i = 0; i < AdoptionGalleryList!.length; i++) {
      var path = AdoptionGalleryList[i].path;
      gallery.add(await dioImport.MultipartFile.fromFile(path,
          filename: path.split('/').last));
    }
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'IDAnimalSubCategory': IDAnimalSubCategory,
      'IDCity': IDCity,
      'PetName': PetName,
      'PetStrain': PetStrain,
      'PetColor': PetColor,
      'PetGender': PetGender,
      'PetAgeMonth': PetAgeMonth,
      'PetAgeYear': PetAgeYear,
      'PetSize': PetSize,
      'PetCondition': PetCondition,
      'PetDescription': PetDescription,
      'AdoptionContact': AdoptionContact,
      "PetPicture": await dioImport.MultipartFile.fromFile("${PetPicture.path}",
          filename: "${PetPicture.path.split('/').last}"),
      "AdoptionGalleryList[]": gallery,
    });
    var response = await dio.post(
      AppConstants.apiUrl + '/api/client/' + 'adoption/add',
      data: formData,
      options: dioImport.Options(
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken
        },
      ),
    );
    var jsonData = response.data;
    if (jsonData["Success"]) {
      log("Add Adoption Animal Api --> $jsonData");
      return jsonData;
    } else {
      log("Add Adoption Animal Api --> $jsonData");
      return jsonData;
    }
  }
}
