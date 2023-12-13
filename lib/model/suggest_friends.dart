// To parse this JSON data, do
//
//     final suggestedFriendList = suggestedFriendListFromJson(jsonString);

import 'dart:convert';

SuggestedFriendList suggestedFriendListFromJson(String str) =>
    SuggestedFriendList.fromJson(json.decode(str));

String suggestedFriendListToJson(SuggestedFriendList data) =>
    json.encode(data.toJson());

class SuggestedFriendList {
  String code;
  String message;
  List<SuggestedFriend> data;

  SuggestedFriendList({
    required this.code,
    required this.message,
    required this.data,
  });

  factory SuggestedFriendList.fromJson(Map<String, dynamic> json) =>
      SuggestedFriendList(
        code: json["code"],
        message: json["message"],
        data: List<SuggestedFriend>.from(
            json["data"].map((x) => SuggestedFriend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SuggestedFriend {
  String id;
  String username;
  String avatar;
  DateTime created;
  String sameFriends;
  bool isRequested = false;
  bool isCancel = false;

  SuggestedFriend({
    required this.id,
    required this.username,
    required this.avatar,
    required this.created,
    required this.sameFriends,
  });

  factory SuggestedFriend.fromJson(Map<String, dynamic> json) =>
      SuggestedFriend(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        created: DateTime.parse(json["created"]),
        sameFriends: json["same_friends"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "created": created.toIso8601String(),
        "same_friends": sameFriends,
      };
}
