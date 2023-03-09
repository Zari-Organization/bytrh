// To parse this JSON data, do
//
//     final productsAnimalsChatMessagesModel = productsAnimalsChatMessagesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProductsAnimalsChatMessagesModel productsAnimalsChatMessagesModelFromJson(String str) => ProductsAnimalsChatMessagesModel.fromJson(json.decode(str));

String productsAnimalsChatMessagesModelToJson(ProductsAnimalsChatMessagesModel data) => json.encode(data.toJson());

class ProductsAnimalsChatMessagesModel {
  ProductsAnimalsChatMessagesModel({
    required this.success,
    required this.apiMsg,
    required this.apiCode,
    required this.response,
  });

  bool success;
  String apiMsg;
  int apiCode;
  Response response;

  factory ProductsAnimalsChatMessagesModel.fromJson(Map<String, dynamic> json) => ProductsAnimalsChatMessagesModel(
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
     this.idAnimalProductChat,
     this.idAnimalProduct,
     this.chatStatus,
     this.clientName,
     this.idClient,
     this.clientPicture,
     this.idBuyer,
     this.buyerName,
     this.buyerPicture,
     this.clientType,
     this.chatDetails,
  });

  final idAnimalProductChat;
  final idAnimalProduct;
  final chatStatus;
  final clientName;
  final idClient;
  final clientPicture;
  final idBuyer;
  final buyerName;
  final buyerPicture;
  final clientType;
  List<ChatDetail>? chatDetails;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
    idAnimalProductChat: json["IDAnimalProductChat"],
    idAnimalProduct: json["IDAnimalProduct"],
    chatStatus: json["ChatStatus"],
    clientName: json["ClientName"],
    idClient: json["IDClient"],
    clientPicture: json["ClientPicture"],
    idBuyer: json["IDBuyer"],
    buyerName: json["BuyerName"],
    buyerPicture: json["BuyerPicture"],
    clientType: json["ClientType"],
    chatDetails: List<ChatDetail>.from(json["ChatDetails"].map((x) => ChatDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "IDAnimalProductChat": idAnimalProductChat,
    "IDAnimalProduct": idAnimalProduct,
    "ChatStatus": chatStatus,
    "ClientName": clientName,
    "IDClient": idClient,
    "ClientPicture": clientPicture,
    "IDBuyer": idBuyer,
    "BuyerName": buyerName,
    "BuyerPicture": buyerPicture,
    "ClientType": clientType,
    "ChatDetails": List<dynamic>.from(chatDetails!.map((x) => x.toJson())),
  };
}

class ChatDetail {
  ChatDetail({
    required this.idChatDetail,
    required this.chatMessage,
    required this.chatType,
    required this.chatSender,
    required this.createDate,
  });

  int idChatDetail;
  String chatMessage;
  String chatType;
  String chatSender;
  DateTime createDate;

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
    idChatDetail: json["IDChatDetail"],
    chatMessage: json["ChatMessage"],
    chatType: json["ChatType"],
    chatSender: json["ChatSender"],
    createDate: DateTime.parse(json["CreateDate"]),
  );

  Map<String, dynamic> toJson() => {
    "IDChatDetail": idChatDetail,
    "ChatMessage": chatMessage,
    "ChatType": chatType,
    "ChatSender": chatSender,
    "CreateDate": createDate.toIso8601String(),
  };
}
