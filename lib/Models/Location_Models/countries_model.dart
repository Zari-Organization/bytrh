// To parse this JSON data, do
//
//     final countriesModel = countriesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CountriesModel countriesModelFromJson(String str) => CountriesModel.fromJson(json.decode(str));

String countriesModelToJson(CountriesModel data) => json.encode(data.toJson());

class CountriesModel {
  CountriesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory CountriesModel.fromJson(Map<String, dynamic> json) => CountriesModel(
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
    required this.idCountry,
  });

  List<Country> countries;
  int idCountry;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    countries: List<Country>.from(json["Countries"].map((x) => Country.fromJson(x))),
    idCountry: json["IDCountry"],
  );

  Map<String, dynamic> toJson() => {
    "Countries": List<dynamic>.from(countries.map((x) => x.toJson())),
    "IDCountry": idCountry,
  };
}

class Country {
  Country({
    required this.idCountry,
    required this.countryName,
  });

  int idCountry;
  String countryName;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    idCountry: json["IDCountry"],
    countryName: json["CountryName"],
  );

  Map<String, dynamic> toJson() => {
    "IDCountry": idCountry,
    "CountryName": countryName,
  };
}
