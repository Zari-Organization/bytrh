// To parse this JSON data, do
//
//     final aboutUsModel = aboutUsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AboutUsModel aboutUsModelFromJson(String str) => AboutUsModel.fromJson(json.decode(str));

String aboutUsModelToJson(AboutUsModel data) => json.encode(data.toJson());

class AboutUsModel {
  AboutUsModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
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
     this.aboutUsTitle,
     this.aboutUsBody,
     this.contactLocation,
     this.contactLocationLat,
     this.contactLocationLong,
     this.contactPhone,
     this.contactEmail,
     this.contactFacebook,
     this.contactInstagram,
     this.contactYouTube,
     this.contactWhatsApp,
  });

  final aboutUsTitle;
  final aboutUsBody;
  final contactLocation;
  final contactLocationLat;
  final contactLocationLong;
  final contactPhone;
  final contactEmail;
  final contactFacebook;
  final contactInstagram;
  final contactYouTube;
  final contactWhatsApp;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    aboutUsTitle: json["AboutUsTitle"],
    aboutUsBody: json["AboutUsBody"],
    contactLocation: json["ContactLocation"],
    contactLocationLat: json["ContactLocationLat"],
    contactLocationLong: json["ContactLocationLong"],
    contactPhone: json["ContactPhone"],
    contactEmail: json["ContactEmail"],
    contactFacebook: json["ContactFacebook"],
    contactInstagram: json["ContactInstagram"],
    contactYouTube: json["ContactYouTube"],
    contactWhatsApp: json["ContactWhatsApp"],
  );

  Map<String, dynamic> toJson() => {
    "AboutUsTitle": aboutUsTitle,
    "AboutUsBody": aboutUsBody,
    "ContactLocation": contactLocation,
    "ContactLocationLat": contactLocationLat,
    "ContactLocationLong": contactLocationLong,
    "ContactPhone": contactPhone,
    "ContactEmail": contactEmail,
    "ContactFacebook": contactFacebook,
    "ContactInstagram": contactInstagram,
    "ContactYouTube": contactYouTube,
    "ContactWhatsApp": contactWhatsApp,
  };
}
