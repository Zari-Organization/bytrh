import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Logic/controllers/Chat_Controllers/chat_controllers.dart';
import '../../Models/Adoptions_Models/adoption_chat_messages_model.dart';
import '../../Models/Consultations_Models/consultations_chat_messages_model.dart';
import '../../Utils/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dioImport;

class ChatServices {
  static Future<ConsultationsChatMessagesModel> getConsultationsChatDetails({
    required String idConsult,
  }) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl +
          '/api/client' +
          '/consult/chat/details/$idConsult'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Consultations Chat Details Api --> $decodedData");
      return consultationsChatMessagesModelFromJson(jsonData);
    } else {
      return consultationsChatMessagesModelFromJson(jsonData);
    }
  }

  static sendChatMessageText({
    required String IDConsult,
    required String ConsultChatType,
    required String ConsultChatMessageText,
    // context,
  }) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'IDConsult': IDConsult,
      'ConsultChatType': ConsultChatType,
      'ConsultChatMessage': ConsultChatMessageText,
    });
    try{
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/consult/chat/reply',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      log("Send Chat Message Text Api --> $jsonData");
      if (jsonData["Success"]) {
        return jsonData;
      } else {
        return jsonData;
      }
    }catch(e){
      log(e.toString());
    }
  }
  static sendChatMessageFile({
    required String IDConsult,
    required String ConsultChatType,
    XFile? ConsultChatMessage,
    context,
  }) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'IDConsult': IDConsult,
      'ConsultChatType': ConsultChatType,
      "ConsultChatMessage": await dioImport.MultipartFile.fromFile(
          "${ConsultChatMessage!.path}",
          filename: "${ConsultChatMessage.path.split('/').last}"),
    });
    try{
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/consult/chat/reply',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      log("Send Chat Message File Api --> $jsonData");
      if (jsonData["Success"]) {
        return jsonData;
      } else {
        return jsonData;
      }
    }catch(e){
      log(e.toString());
    }
  }

  static endConsultChat(String id) async {
    var response = await http.get(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/chat/end/$id'),
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      log("End Chat Api --> $decodedData");
      return decodedData;
    }else {
      log("End Chat Api --> $decodedData");
      return decodedData;
    }
  }

  static sendComplaintConsultChat(String idConsult,String complainBody) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl + '/api/client' + '/consult/chat/complain'),
      body: {
        'IDConsult': idConsult,
        'ClientComplainBody': complainBody,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData["Success"]) {
      log("Send Complaint Api --> $decodedData");
      return decodedData;
    }else {
      log("Send Complaint Api --> $decodedData");
      return decodedData;
    }
  }


  static Future<AdoptionChatMessagesModel> getAdoptionChatDetails({
    required String clientType,
    required String idAdoptionChat,
  }) async {
    var response = await http.post(
      Uri.parse(AppConstants.apiUrl +
          '/api/client' + '/adoption/chat/details'),
      body: {
        'ClientType': clientType,
        'IDAdoptionChat': idAdoptionChat,
      },
      headers: {
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: AppConstants().UserTocken
      },
    );
    var jsonData = response.body;
    var decodedData = jsonDecode(jsonData);
    if (decodedData['Success']) {
      log("Adoption Chat Details Api --> $decodedData");
      return adoptionChatMessagesModelFromJson(jsonData);
    } else {
      log("Adoption Chat Details Api --> $decodedData");
      return adoptionChatMessagesModelFromJson(jsonData);
    }
  }

  static sendAdoptionChatMessageText({
    required String ClientType,
    required String IDAdoptionChat,
    required String AdoptionChatType,
    required String AdoptionChatMessage,
    // context,
  }) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'ClientType': ClientType,
      'IDAdoptionChat': IDAdoptionChat,
      'AdoptionChatMessage': AdoptionChatMessage,
      'AdoptionChatType': AdoptionChatType,
    });
    try{
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/adoption/chat/reply',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      log("Send Adoption Chat Message Text Api --> $jsonData");
      if (jsonData["Success"]) {
        return jsonData;
      } else {
        return jsonData;
      }
    }catch(e){
      log(e.toString());
    }
  }
  static sendAdoptionChatMessageFile({
    required String ClientType,
    required String IDAdoptionChat,
    required String AdoptionChatType,
    XFile? AdoptionChatMessage,
    context,
  }) async {
    dioImport.Dio dio = dioImport.Dio();
    dioImport.FormData formData = dioImport.FormData.fromMap({
      'ClientType': ClientType,
      'IDAdoptionChat': IDAdoptionChat,
      'AdoptionChatType': AdoptionChatType,
      "AdoptionChatMessage": await dioImport.MultipartFile.fromFile(
          "${AdoptionChatMessage!.path}",
          filename: "${AdoptionChatMessage.path.split('/').last}"),
    });
    try{
      var response = await dio.post(
        AppConstants.apiUrl + '/api/client' + '/adoption/chat/reply',
        data: formData,
        options: dioImport.Options(
          headers: {
            'Accept': 'application/json',
            HttpHeaders.authorizationHeader: AppConstants().UserTocken
          },
        ),
      );
      var jsonData = response.data;
      log("Send Adoption Chat Message File Api --> $jsonData");
      if (jsonData["Success"]) {
        return jsonData;
      } else {
        return jsonData;
      }
    }catch(e){
      log(e.toString());
    }
  }

}
