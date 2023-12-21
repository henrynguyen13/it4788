// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

import 'dart:convert';

Notification notificationFromJson(String str) =>
    Notification.fromJson(json.decode(str));

String notificationToJson(Notification data) => json.encode(data.toJson());

class Notification {
  String type;
  String objectId;
  String title;
  String notificationId;
  DateTime created;
  String avatar;
  String group;
  String read;
  UserNoti user;
  PostNoti post;
  dynamic mark;
  dynamic feel;

  Notification({
    required this.type,
    required this.objectId,
    required this.title,
    required this.notificationId,
    required this.created,
    required this.avatar,
    required this.group,
    required this.read,
    required this.user,
    required this.post,
    required this.mark,
    required this.feel,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        type: json["type"],
        objectId: json["object_id"],
        title: json["title"],
        notificationId: json["notification_id"],
        created: DateTime.parse(json["created"]),
        avatar: json["avatar"],
        group: json["group"],
        read: json["read"],
        user: UserNoti.fromJson(json["user"]),
        post: PostNoti.fromJson(json["post"]),
        mark: json["mark"],
        feel: json["feel"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "object_id": objectId,
        "title": title,
        "notification_id": notificationId,
        "created": created.toIso8601String(),
        "avatar": avatar,
        "group": group,
        "read": read,
        "user": user.toJson(),
        "post": post.toJson(),
        "mark": mark,
        "feel": feel,
      };
}

class PostNoti {
  String id;
  String described;
  String status;

  PostNoti({
    required this.id,
    required this.described,
    required this.status,
  });

  factory PostNoti.fromJson(Map<String, dynamic> json) => PostNoti(
        id: json["id"],
        described: json["described"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "described": described,
        "status": status,
      };
}

class UserNoti {
  String id;
  String username;
  String avatar;

  UserNoti({
    required this.id,
    required this.username,
    required this.avatar,
  });

  factory UserNoti.fromJson(Map<String, dynamic> json) => UserNoti(
        id: json["id"],
        username: json["username"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "avatar": avatar,
      };
}
