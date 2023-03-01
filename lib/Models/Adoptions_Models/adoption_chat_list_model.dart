// To parse this JSON data, do
//
//     final adoptionChatListModel = adoptionChatListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdoptionChatListModel adoptionChatListModelFromJson(String str) => AdoptionChatListModel.fromJson(json.decode(str));

String adoptionChatListModelToJson(AdoptionChatListModel data) => json.encode(data.toJson());

class AdoptionChatListModel {
  AdoptionChatListModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory AdoptionChatListModel.fromJson(Map<String, dynamic> json) => AdoptionChatListModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    required this.idAdoptionChat,
    required this.adoptionChatStatus,
    required this.clientName,
    required this.clientPhone,
    required this.clientPicture,
    required this.adopterName,
    required this.adopterPhone,
    required this.adopterPicture,
    required this.adoptionContact,
    required this.adoptionChatSeen,
    required this.adopterChatSeen,
  });

  int idAdoptionChat;
  String adoptionChatStatus;
  String clientName;
  String clientPhone;
  String clientPicture;
  String adopterName;
  String adopterPhone;
  String adopterPicture;
  int adoptionContact;
  int adoptionChatSeen;
  int adopterChatSeen;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAdoptionChat: json["IDAdoptionChat"],
    adoptionChatStatus: json["AdoptionChatStatus"],
    clientName: json["ClientName"],
    clientPhone: json["ClientPhone"],
    clientPicture: json["ClientPicture"],
    adopterName: json["AdopterName"],
    adopterPhone: json["AdopterPhone"],
    adopterPicture: json["AdopterPicture"],
    adoptionContact: json["AdoptionContact"],
    adoptionChatSeen: json["AdoptionChatSeen"],
    adopterChatSeen: json["AdopterChatSeen"],
  );

  Map<String, dynamic> toJson() => {
    "IDAdoptionChat": idAdoptionChat,
    "AdoptionChatStatus": adoptionChatStatus,
    "ClientName": clientName,
    "ClientPhone": clientPhone,
    "ClientPicture": clientPicture,
    "AdopterName": adopterName,
    "AdopterPhone": adopterPhone,
    "AdopterPicture": adopterPicture,
    "AdoptionContact": adoptionContact,
    "AdoptionChatSeen": adoptionChatSeen,
    "AdopterChatSeen": adopterChatSeen,
  };
}
