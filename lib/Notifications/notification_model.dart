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
  });

  String idData;
  String notificationType;
  String screen;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        idData: json["IDData"],
        notificationType: json["NotificationType"],
        screen: json["Screen"],
      );

  Map<String, dynamic> toJson() => {
        "IDData": idData,
        "NotificationType": notificationType,
        "Screen": screen,
      };
}
