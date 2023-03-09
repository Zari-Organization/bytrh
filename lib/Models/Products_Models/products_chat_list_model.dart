// To parse this JSON data, do
//
//     final productsAnimalsChatsListModel = productsAnimalsChatsListModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsAnimalsChatsListModel productsAnimalsChatsListModelFromJson(String str) => ProductsAnimalsChatsListModel.fromJson(json.decode(str));

String productsAnimalsChatsListModelToJson(ProductsAnimalsChatsListModel data) => json.encode(data.toJson());

class ProductsAnimalsChatsListModel {
  ProductsAnimalsChatsListModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  List<Response> response;

  factory ProductsAnimalsChatsListModel.fromJson(Map<String, dynamic> json) => ProductsAnimalsChatsListModel(
    success: json["Success"],
    apiMsg: json["ApiMsg"],
    apiCode: json["ApiCode"],
    response: List<Response>.from(json["Response"].map((x) => Response.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "ApiMsg": apiMsg,
    "ApiCode": apiCode,
    "Response": List<dynamic>.from(response.map((x) => x.toJson())),
  };
}

class Response {
  Response({
    required this.idAnimalProductChat,
    required this.idAnimalProduct,
    required this.chatStatus,
    required this.clientType,
    required this.clientName,
    required this.clientPicture,
    required this.buyerName,
    required this.buyerPicture,
    required this.chatSeen,
  });

  int idAnimalProductChat;
  int idAnimalProduct;
  String chatStatus;
  String clientType;
  String clientName;
  String clientPicture;
  String buyerName;
  String buyerPicture;
  int chatSeen;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProductChat: json["IDAnimalProductChat"],
    idAnimalProduct: json["IDAnimalProduct"],
    chatStatus: json["ChatStatus"],
    clientType: json["ClientType"],
    clientName: json["ClientName"],
    clientPicture: json["ClientPicture"],
    buyerName: json["BuyerName"],
    buyerPicture: json["BuyerPicture"],
    chatSeen: json["ChatSeen"],
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProductChat": idAnimalProductChat,
    "IDAnimalProduct": idAnimalProduct,
    "ChatStatus": chatStatus,
    "ClientType": clientType,
    "ClientName": clientName,
    "ClientPicture": clientPicture,
    "BuyerName": buyerName,
    "BuyerPicture": buyerPicture,
    "ChatSeen": chatSeen,
  };
}
