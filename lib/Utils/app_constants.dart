import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

class AppConstants {

  static const String apiUrl = "https://zariexpress.com";

  String UserTocken = GetStorage().read<String>('AccessToken')??"";
  static const String placeholder = 'assets/images/placeholder.jpg';
  static double mediaHeight(context) => MediaQuery.of(context).size.height;
  static double mediaWidth(context) => MediaQuery.of(context).size.width;
  static const double widgetsCurve = 5;
}
