// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CitiesModel citiesModelFromJson(String str) => CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  CitiesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
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
    required this.countries,
    required this.idCity,
  });

  List<Country> countries;
  int idCity;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    countries: List<Country>.from(json["Countries"].map((x) => Country.fromJson(x))),
    idCity: json["IDCity"],
  );

  Map<String, dynamic> toJson() => {
    "Countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    "IDCity": idCity,
  };
}

class Country {
  Country({
    required this.idCountry,
    required this.idCity,
    required this.cityName,
  });

  int idCountry;
  int idCity;
  String cityName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    idCountry: json["IDCountry"],
    idCity: json["IDCity"],
    cityName: json["CityName"],
  );

  Map<String, dynamic> toJson() => {
    "IDCountry": idCountry,
    "IDCity": idCity,
    "CityName": cityName,
  };
}
