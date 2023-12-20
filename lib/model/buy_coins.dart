// To parse this JSON data, do
//
//     final buyCoins = buyCoinsFromJson(jsonString);

import 'dart:convert';

BuyCoins buyCoinsFromJson(String str) => BuyCoins.fromJson(json.decode(str));

String buyCoinsToJson(BuyCoins data) => json.encode(data.toJson());

class BuyCoins {
  String code;
  String message;
  Data data;

  BuyCoins({
    required this.code,
    required this.message,
    required this.data,
  });

  factory BuyCoins.fromJson(Map<String, dynamic> json) => BuyCoins(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int coins;

  Data({
    required this.coins,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        coins: json["coins"],
      );

  Map<String, dynamic> toJson() => {
        "coins": coins,
      };
}
