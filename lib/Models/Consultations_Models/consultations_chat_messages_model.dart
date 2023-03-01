// To parse this JSON data, do
//
//     final consultationsChatMessagesModel = consultationsChatMessagesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ConsultationsChatMessagesModel consultationsChatMessagesModelFromJson(String str) => ConsultationsChatMessagesModel.fromJson(json.decode(str));

String consultationsChatMessagesModelToJson(ConsultationsChatMessagesModel data) => json.encode(data.toJson());

class ConsultationsChatMessagesModel {
  ConsultationsChatMessagesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory ConsultationsChatMessagesModel.fromJson(Map<String, dynamic> json) => ConsultationsChatMessagesModel(
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
     this.idConsult,
     this.consultStatus,
     this.createdAt,
     this.idClient,
     this.clientName,
     this.idDoctor,
     this.doctorName,
     this.createDate,
     this.chatDetails,
    this.consultCountDown
  });

  final idConsult;
  final consultStatus;
  DateTime? createdAt;
  final idClient;
  final clientName;
  final idDoctor;
  final doctorName;
  final createDate;
  List<ChatDetail>? chatDetails;
  ConsultCountDown? consultCountDown;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idConsult: json["IDConsult"],
    consultStatus: json["ConsultStatus"],
    createdAt: DateTime.parse(json["created_at"]),
    idClient: json["IDClient"],
    clientName: json["ClientName"],
    idDoctor: json["IDDoctor"],
    doctorName: json["DoctorName"],
    createDate: DateTime.parse(json["CreateDate"]),
    chatDetails: List<ChatDetail>.from(json["ChatDetails"].map((x) => ChatDetail.fromJson(x))),
    consultCountDown: ConsultCountDown.fromJson(json["ConsultCountDown"]),
  );

  Map<String, dynamic> toJson() => {
    "IDConsult": idConsult,
    "ConsultStatus": consultStatus,
    "created_at": createdAt!.toIso8601String(),
    "IDClient": idClient,
    "ClientName": clientName,
    "IDDoctor": idDoctor,
    "DoctorName": doctorName,
    "CreateDate": createDate.toIso8601String(),
    "ChatDetails": List<dynamic>.from(chatDetails!.map((x) => x.toJson())),
    "ConsultCountDown": consultCountDown!.toJson(),
  };
}

class ChatDetail {
  ChatDetail({
    required this.idConsultChat,
    required this.consultChatMessage,
    required this.consultChatType,
    required this.consultChatSender,
    required this.createDate,
  });

  int idConsultChat;
  String consultChatMessage;
  String consultChatType;
  String consultChatSender;
  DateTime createDate;

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
    idConsultChat: json["IDConsultChat"],
    consultChatMessage: json["ConsultChatMessage"],
    consultChatType: json["ConsultChatType"],
    consultChatSender: json["ConsultChatSender"],
    createDate: DateTime.parse(json["CreateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "IDConsultChat": idConsultChat,
    "ConsultChatMessage": consultChatMessage,
    "ConsultChatType": consultChatType,
    "ConsultChatSender": consultChatSender,
    "CreateDate": createDate.toIso8601String(),
  };
}
class ConsultCountDown {
  ConsultCountDown({
    this.days,
    this.hours,
    this.minutes,
  });

  final days;
  final hours;
  final minutes;

  factory ConsultCountDown.fromJson(Map<String, dynamic> json) => ConsultCountDown(
    days: json["Days"],
    hours: json["Hours"],
    minutes: json["Minutes"],
  );

  Map<String, dynamic> toJson() => {
    "Days": days,
    "Hours": hours,
    "Minutes": minutes,
  };
}
