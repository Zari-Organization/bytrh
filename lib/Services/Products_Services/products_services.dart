import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;
import 'package:image_picker/image_picker.dart';

import '../../Logic/controllers/Adoption_Controllers/adoption_controller.dart';
import '../../Models/Adoptions_Models/adoption_animals_categories_model.dart';
import '../../Models/Adoptions_Models/adoption_chat_messages_model.dart';
import '../../Models/Adoptions_Models/adoption_chat_list_model.dart';
import '../../Models/Adoptions_Models/adoption_details_model.dart';
import '../../Models/Adoptions_Models/adoption_list_model.dart';
import '../../Models/Products_Models/animal_product_bagging_model.dart';
import '../../Models/Products_Models/animal_product_cutting_model.dart';
import '../../Models/Products_Models/animal_product_details_model.dart';
import '../../Models/Products_Models/animal_products_model.dart';
import '../../Models/Products_Models/products_categories_model.dart';
import '../../Models/Products_Models/products_my_animals_model.dart';
import '../../Models/Products_Models/products_subCategories_model.dart';
import '../../Utils/app_constants.dart';

class ProductsServices {
  static Future<ProductsCategoriesModel> getProductsCategory() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client/' + 'animalcategories'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Products Category Api --> $decodedData");
      return productsCategoriesModelFromJson(jsonData);
    } else {
      log("Products Category Api --> $decodedData");
      return productsCategoriesModelFromJson(jsonData);
    }
  }

  static Future<ProductsSubCategoriesModel> getProductSubCategories(
      String id) async {
    var response = await http.get(
      Uri.parse(
          AppConstants.apiUrl + '/api/client/' + 'animalsubcategories/$id'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Products SubCategories Api --> $decodedData");
      return productsSubCategoriesModelFromJson(jsonData);
    } else {
      log("Products SubCategories Api --> $decodedData");
      return productsSubCategoriesModelFromJson(jsonData);
    }
  }

  static Future<AnimalProductsModel> getAnimalProducts(String id) async {
    var response = await http.post(
        Uri.parse(
            AppConstants.apiUrl + '/api/client/' + 'store/animalproducts'),
        body: {
          "IDAnimalSubCategory": id,
        });

    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Animal Products Api --> $decodedData");
      return animalProductsModelFromJson(jsonData);
    } else {
      log("Animal Products Api --> $decodedData");
      return animalProductsModelFromJson(jsonData);
    }
  }

  static Future<AnimalProductDetailsModel> getAnimalProductDetails(
      String id) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl +
          '/api/client/' +
          'store/animalproducts/details/$id'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Animal Product Details Api --> $decodedData");
      return animalProductDetailsModelFromJson(jsonData);
    } else {
      log("Animal Product Details Api --> $decodedData");
      return animalProductDetailsModelFromJson(jsonData);
    }
  }

  static Future<AnimalProductCuttingModel> getAnimalProductCutting(
      String id) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl +
          '/api/client/' +
          'store/animalproducts/cutting/$id'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Animal Product Cutting Api --> $decodedData");
      return animalProductCuttingModelFromJson(jsonData);
    } else {
      log("Animal Product Cutting Api --> $decodedData");
      return animalProductCuttingModelFromJson(jsonData);
    }
  }

  static Future<AnimalProductBaggingModel> getAnimalProductBagging(
      String id) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl +
          '/api/client/' +
          'store/animalproducts/bagging/$id'),
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Animal Product Bagging Api --> $decodedData");
      return animalProductBaggingModelFromJson(jsonData);
    } else {
      log("Animal Product Bagging Api --> $decodedData");
      return animalProductBaggingModelFromJson(jsonData);
    }
  }

  static requestPurchaseAnimalProduct(
    String IDAnimalProduct,
    String IDCutting,
    String IDBagging,
    String Delivery,
    String Note,
  ) async {
    var response = await http.post(
      Uri.parse(
        AppConstants.apiUrl + '/api/client/' + 'store/animalproducts/request',
      ),
      body: {
        "IDAnimalProduct": IDAnimalProduct,
        "IDCutting": IDCutting,
        "IDBagging": IDBagging,
        "Delivery": Delivery,
        "Note": Note,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Request PurchaseAnimal Product Api --> $decodedData");
      return decodedData;
    } else {
      log("Request PurchaseAnimal Product Api --> $decodedData");
      return decodedData;
    }
  }

  addProductAnimal({
    required String IDAnimalSubCategory,
    required String IDCity,
    required String AnimalProductGender,
    required String AnimalProductAge,
    String? AnimalProductSize,
    String? AnimalProductPrice,
    String? AnimalProductDescription,
    required String AnimalProductType,
    required String HasBagging,
    required String HasCutting,
    required String HasDelivery,
    required String AllowPhone,
    required String AllowWhatsapp,
    required File AnimalProductImage,
    List<XFile>? AnimalProductGalleryList,
    context}) async {
    dioImport.Dio dio = dioImport.Dio();
    List<dynamic>? gallery = [];
    for (int i = 0; i < AnimalProductGalleryList!.length; i++) {
      var path = AnimalProductGalleryList[i].path;
      gallery.add(await dioImport.MultipartFile.fromFile(path,
          filename: path.split('/').last));
    }
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'IDAnimalSubCategory': IDAnimalSubCategory,
      'IDCity': IDCity,
      'AnimalProductGender': AnimalProductGender,
      'AnimalProductSize': AnimalProductSize,
      'AnimalProductAge': AnimalProductAge,
      'AnimalProductDescription': AnimalProductDescription,
      'AnimalProductType': AnimalProductType,
      'AnimalProductPrice': AnimalProductPrice,
      'HasBagging': HasBagging,
      'HasCutting': HasCutting,
      'HasDelivery': HasDelivery,
      'AllowPhone': AllowPhone,
      'AllowWhatsapp': AllowWhatsapp,
      "AnimalProductImage": await dioImport.MultipartFile.fromFile("${AnimalProductImage.path}",
          filename: "${AnimalProductImage.path.split('/').last}"),
      "AnimalProductGallery[]": gallery,
    });
    var response = await dio.post(
      AppConstants.apiUrl + '/api/client/' + 'store/animalproducts/add',
      data: formData,
      options: dioImport.Options(
        headers: {
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: AppConstants().UserTocken
        },
      ),
    );
    var jsonData = response.data;
    log("Add Product Animal Api --> $jsonData");
    if (jsonData["Success"]) {
      log("Add Product Animal Api --> $jsonData");
      return jsonData;
    } else {
      log("Add Product Animal Api --> $jsonData");
      return jsonData;
    }
  }

  static Future<ProductsMyAnimalsModel> getProductsMyAnimals() async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client/' + 'store/animalproducts'),
      body: {
        "AnimalProductHistory": "HISTORY",
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Products My Animals Api --> $decodedData");
      return productsMyAnimalsModelFromJson(jsonData);
    } else {
      log("Products My Animals Api --> $decodedData");
      return productsMyAnimalsModelFromJson(jsonData);
    }
  }

}
