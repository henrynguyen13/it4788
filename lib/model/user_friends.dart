// To parse this JSON data, do
//
//     final userFriends = userFriendsFromJson(jsonString);

import 'dart:convert';

UserFriends userFriendsFromJson(String str) =>
    UserFriends.fromJson(json.decode(str));

String userFriendsToJson(UserFriends data) => json.encode(data.toJson());

class UserFriends {
  String code;
  String message;
  Data data;

  UserFriends({
    required this.code,
    required this.message,
    required this.data,
  });

  factory UserFriends.fromJson(Map<String, dynamic> json) => UserFriends(
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
  List<Friend> friends;
  String total;

  Data({
    required this.friends,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        friends:
            List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "friends": List<dynamic>.from(friends.map((x) => x.toJson())),
        "total": total,
      };
}

class Friend {
  String id;
  String username;
  String avatar;
  String sameFriends;
  String created;

  Friend({
    required this.id,
    required this.username,
    required this.avatar,
    required this.sameFriends,
    required this.created,
  });

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        sameFriends: json["same_friends"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "same_friends": sameFriends,
        "created": created,
      };
}
