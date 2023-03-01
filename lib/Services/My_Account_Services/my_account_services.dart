import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../../Models/AboutUs_Models/about_us_model.dart';
import '../../Models/AboutUs_Models/chat_support_model.dart';
import '../../Utils/app_constants.dart';
import 'package:dio/dio.dart' as dioImport;
class MyAccountServices {
  static logout() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/logout'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      if (kDebugMode) {
        print("Logout Api Success --> $decodedData");
      }

      return decodedData;
    }else if(!decodedData["Success"]){
      if (kDebugMode) {
        print("Logout Api Error --> $decodedData");
      }
      return decodedData;
    } else {
      return throw Exception("Failed to Logout");
    }
  }
  static Future<AboutUsModel> getAboutUs() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/about'),
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] == true) {
      log("About Us Api --> $decodedData");

      return aboutUsModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }
  static Future<AboutUsModel> getContactUs() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/contact'),
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] == true) {
      if (kDebugMode) {
        print("Contact Us Api --> $decodedData");
      }

      return aboutUsModelFromJson(jsonData);
    } else {
      return throw Exception(decodedData['ApiMsg']);
    }
  }

  sentToContactUs(
      String UserName,
      String Email,
      String Message,
      ) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/contact'),
      body: {
        'UserName': UserName,
        'Email': Email,
        'Message': Message,
      },
      headers: {
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success'] ) {
      log("Contact Us Api --> $decodedData");
      return decodedData;
    } else {
      return decodedData;
    }
  }
  static requestChatSupport() async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/support/chat/request'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      log("Request Chat Support Api --> $decodedData");
      return decodedData;
    }else {
      log("Request Chat Support  Api --> $decodedData");
      return decodedData;
    }
  }

  static Future<ChatSupportModel> getChatSupportDetails({
    required String idChat,
  }) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl +
          '/api/client' + '/support/chat/details/$idChat'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Chat Support Details Api --> $decodedData");
      return chatSupportModelFromJson(jsonData);
    } else {
      log("Chat Support Details Api --> $decodedData");
      return chatSupportModelFromJson(jsonData);
    }
  }

  static sendChatSupportMessageText({
    required String IDClientChatSupport,
    required String ChatSupportType,
    required String ChatSupportMessage,
    // context,
  }) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'IDClientChatSupport': IDClientChatSupport,
      'ChatSupportType': ChatSupportType,
      'ChatSupportMessage': ChatSupportMessage,
    });
    try{
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/support/chat/reply',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      log("Send Chat Support Message Text Api --> $jsonData");
      if (jsonData["Success"]) {
        return jsonData;
      } else {
        return jsonData;
      }
    }catch(e){
      log(e.toString());
    }
  }
  static sendChatSupportMessageFile({
    required String IDClientChatSupport,
    required String ChatSupportType,
    XFile? ChatSupportMessage,
    context,
  }) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'IDClientChatSupport': IDClientChatSupport,
      'ChatSupportType': ChatSupportType,
      "ChatSupportMessage": await dioImport.MultipartFile.fromFile(
          "${ChatSupportMessage!.path}",
          filename: "${ChatSupportMessage.path.split('/').last}"),
    });
    try{
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/support/chat/reply',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      log("Send Chat Support Message File Api --> $jsonData");
      if (jsonData["Success"]) {
        return jsonData;
      } else {
        return jsonData;
      }
    }catch(e){
      log(e.toString());
    }
  }

  static endChatSupport(String id) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/support/chat/end/$id'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      log("End Chat Support Api --> $decodedData");
      return decodedData;
    }else {
      log("End Chat Support Api --> $decodedData");
      return decodedData;
    }
  }
}
