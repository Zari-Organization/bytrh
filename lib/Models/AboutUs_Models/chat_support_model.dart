// To parse this JSON data, do
//
//     final chatSupportModel = chatSupportModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChatSupportModel chatSupportModelFromJson(String str) => ChatSupportModel.fromJson(json.decode(str));

String chatSupportModelToJson(ChatSupportModel data) => json.encode(data.toJson());

class ChatSupportModel {
  ChatSupportModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory ChatSupportModel.fromJson(Map<String, dynamic> json) => ChatSupportModel(
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
     this.idClientChatSupport,
     this.chatSupportStatus,
     this.clientName,
     this.userName,
     this.chatDetails,
  });

  final idClientChatSupport;
  final chatSupportStatus;
  final clientName;
  final userName;
  List<ChatDetail>? chatDetails;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idClientChatSupport: json["IDClientChatSupport"],
    chatSupportStatus: json["ChatSupportStatus"],
    clientName: json["ClientName"],
    userName: json["UserName"],
    chatDetails: List<ChatDetail>.from(json["ChatDetails"].map((x) => ChatDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IDClientChatSupport": idClientChatSupport,
    "ChatSupportStatus": chatSupportStatus,
    "ClientName": clientName,
    "UserName": userName,
    "ChatDetails": List<dynamic>.from(chatDetails!.map((x) => x.toJson())),
  };
}

class ChatDetail {
  ChatDetail({
    required this.idChatSupportDetails,
    required this.chatSupportMessage,
    required this.chatSupportType,
    required this.chatSupportSender,
    required this.createDate,
  });

  int idChatSupportDetails;
  String chatSupportMessage;
  String chatSupportType;
  String chatSupportSender;
  DateTime createDate;

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
    idChatSupportDetails: json["IDChatSupportDetails"],
    chatSupportMessage: json["ChatSupportMessage"],
    chatSupportType: json["ChatSupportType"],
    chatSupportSender: json["ChatSupportSender"],
    createDate: DateTime.parse(json["CreateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "IDChatSupportDetails": idChatSupportDetails,
    "ChatSupportMessage": chatSupportMessage,
    "ChatSupportType": chatSupportType,
    "ChatSupportSender": chatSupportSender,
    "CreateDate": createDate.toIso8601String(),
  };
}
