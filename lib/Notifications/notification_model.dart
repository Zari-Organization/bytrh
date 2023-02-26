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
    required this.message,
    required this.idData,
    required this.screen,
    required this.notificationType,
    required this.dataType,
  });

  String message;
  String idData;
  String screen;
  String notificationType;
  String dataType;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        message: json["Message"],
        idData: json["IDData"],
        screen: json["Screen"],
        notificationType: json["NotificationType"],
        dataType: json["DataType"],
      );

  Map<String, dynamic> toJson() => {
    "Message": message,
        "IDData": idData,
        "Screen": screen,
    "NotificationType": notificationType,
    "DataType": dataType,
      };
}
