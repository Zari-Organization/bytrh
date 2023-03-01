// To parse this JSON data, do
//
//     final adoptionChatMessagesModel = adoptionChatMessagesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AdoptionChatMessagesModel adoptionChatMessagesModelFromJson(String str) => AdoptionChatMessagesModel.fromJson(json.decode(str));

String adoptionChatMessagesModelToJson(AdoptionChatMessagesModel data) => json.encode(data.toJson());

class AdoptionChatMessagesModel {
  AdoptionChatMessagesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory AdoptionChatMessagesModel.fromJson(Map<String, dynamic> json) => AdoptionChatMessagesModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: Response.fromJson(json["Response"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": response.toJson(),
  };
}

class Response {
  Response({
    this.idAdoptionChat,
    this.idAdoption,
    this.adoptionChatStatus,
    this.adoptionContact,
    this.clientName,
    this.clientPhone,
    this.clientPicture,
    this.adopterName,
    this.adopterPhone,
    this.adopterPicture,
    this.chatDetails,
  });

  final idAdoptionChat;
  final idAdoption;
  final adoptionChatStatus;
  final adoptionContact;
  final clientName;
  final clientPhone;
  final clientPicture;
  final adopterName;
  final adopterPhone;
  final adopterPicture;
  List<ChatDetail>? chatDetails;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAdoptionChat: json["IDAdoptionChat"],
    idAdoption: json["IDAdoption"],
    adoptionChatStatus: json["AdoptionChatStatus"],
    adoptionContact: json["AdoptionContact"],
    clientName: json["ClientName"],
    clientPhone: json["ClientPhone"],
    clientPicture: json["ClientPicture"],
    adopterName: json["AdopterName"],
    adopterPhone: json["AdopterPhone"],
    adopterPicture: json["AdopterPicture"],
    chatDetails: List<ChatDetail>.from(json["ChatDetails"].map((x) => ChatDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IDAdoptionChat": idAdoptionChat,
    "IDAdoption": idAdoption,
    "AdoptionChatStatus": adoptionChatStatus,
    "AdoptionContact": adoptionContact,
    "ClientName": clientName,
    "ClientPhone": clientPhone,
    "ClientPicture": clientPicture,
    "AdopterName": adopterName,
    "AdopterPhone": adopterPhone,
    "AdopterPicture": adopterPicture,
    "ChatDetails": List<dynamic>.from(chatDetails!.map((x) => x.toJson())),
  };
}

class ChatDetail {
  ChatDetail({
    required this.idAdoptionChatDetail,
    required this.adoptionChatMessage,
    required this.adoptionChatType,
    required this.adoptionChatSender,
    required this.createDate,
  });

  int idAdoptionChatDetail;
  String adoptionChatMessage;
  String adoptionChatType;
  String adoptionChatSender;
  DateTime createDate;

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
    idAdoptionChatDetail: json["IDAdoptionChatDetail"],
    adoptionChatMessage: json["AdoptionChatMessage"],
    adoptionChatType: json["AdoptionChatType"],
    adoptionChatSender: json["AdoptionChatSender"],
    createDate: DateTime.parse(json["CreateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "IDAdoptionChatDetail": idAdoptionChatDetail,
    "AdoptionChatMessage": adoptionChatMessage,
    "AdoptionChatType": adoptionChatType,
    "AdoptionChatSender": adoptionChatSender,
    "CreateDate": createDate.toIso8601String(),
  };
}
