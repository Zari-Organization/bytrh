// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    required this.idData,
    required this.notificationType,
    required this.screen,
    required this.idUser,
    required this.dataType,
    required this.message,
  });

  String idData;
  String notificationType;
  String screen;
  String idUser;
  String dataType;
  String message;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        idData: json["IDData"],
        notificationType: json["NotificationType"],
        screen: json["Screen"],
        idUser: json["IDUser"],
        dataType: json["DataType"],
        message: json["Message"],
      );

  Map<String, dynamic> toJson() => {
        "IDData": idData,
        "NotificationType": notificationType,
        "Screen": screen,
        "IDUser": idUser,
        "DataType": dataType,
        "Message": message,
      };
}
