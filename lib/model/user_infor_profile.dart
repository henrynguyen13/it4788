// To parse this JSON data, do
//
//     final userInfor = userInforFromJson(jsonString);

import 'dart:convert';

UserInfor userInforFromJson(String str) => UserInfor.fromJson(json.decode(str));

String userInforToJson(UserInfor data) => json.encode(data.toJson());

class UserInfor {
  String code;
  String message;
  Data data;

  UserInfor({
    required this.code,
    required this.message,
    required this.data,
  });

  factory UserInfor.fromJson(Map<String, dynamic> json) => UserInfor(
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
  String id;
  String username;
  String created;
  String description;
  String avatar;
  String coverImage;
  String link;
  String address;
  String city;
  String country;
  String listing;
  String isFriend;
  String online;
  String coins;

  Data({
    required this.id,
    required this.username,
    required this.created,
    required this.description,
    required this.avatar,
    required this.coverImage,
    required this.link,
    required this.address,
    required this.city,
    required this.country,
    required this.listing,
    required this.isFriend,
    required this.online,
    required this.coins,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        created: json["created"],
        description: json["description"],
        avatar: json["avatar"],
        coverImage: json["cover_image"],
        link: json["link"],
        address: json["address"],
        city: json["city"],
        country: json["country"],
        listing: json["listing"],
        isFriend: json["is_friend"],
        online: json["online"],
        coins: json["coins"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "created": created,
        "description": description,
        "avatar": avatar,
        "cover_image": coverImage,
        "link": link,
        "address": address,
        "city": city,
        "country": country,
        "listing": listing,
        "is_friend": isFriend,
        "online": online,
        "coins": coins,
      };
}
