// To parse this JSON data, do
//
//     final requestFriends = requestFriendsFromJson(jsonString);

import 'dart:convert';

RequestFriendList requestFriendsFromJson(String str) =>
    RequestFriendList.fromJson(json.decode(str));

String requestFriendsToJson(RequestFriendList data) =>
    json.encode(data.toJson());

class RequestFriendList {
  String code;
  String message;
  Data data;

  RequestFriendList({
    required this.code,
    required this.message,
    required this.data,
  });

  factory RequestFriendList.fromJson(Map<String, dynamic> json) =>
      RequestFriendList(
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
  List<RequestFriend> requests;
  String total;

  Data({
    required this.requests,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        requests: List<RequestFriend>.from(
            json["requests"].map((x) => RequestFriend.fromJson(x))),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "requests": List<dynamic>.from(requests.map((x) => x.toJson())),
        "total": total,
      };
}

class RequestFriend {
  String id;
  String username;
  String avatar;
  String sameFriends;
  DateTime created;
  bool isAccept = false;
  bool isCancel = false;

  RequestFriend({
    required this.id,
    required this.username,
    required this.avatar,
    required this.sameFriends,
    required this.created,
  });

  factory RequestFriend.fromJson(Map<String, dynamic> json) => RequestFriend(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
        sameFriends: json["same_friends"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
        "same_friends": sameFriends,
        "created": created.toIso8601String(),
      };
}
