// To parse this JSON data, do
//
//     final listNotification = listNotificationFromJson(jsonString);

import 'dart:convert';

ListNotification listNotificationFromJson(String str) =>
    ListNotification.fromJson(json.decode(str));

String listNotificationToJson(ListNotification data) =>
    json.encode(data.toJson());

class ListNotification {
  String? code;
  String? message;
  List<ItemNotification>? data;
  DateTime? lastUpdate;
  String? badge;

  ListNotification({
    this.code,
    this.message,
    this.data,
    this.lastUpdate,
    this.badge,
  });

  factory ListNotification.fromJson(Map<String, dynamic> json) =>
      ListNotification(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ItemNotification>.from(
                json["data"]!.map((x) => ItemNotification.fromJson(x))),
        lastUpdate: json["last_update"] == null
            ? null
            : DateTime.parse(json["last_update"]),
        badge: json["badge"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "last_update": lastUpdate?.toIso8601String(),
        "badge": badge,
      };
}

class ItemNotification {
  String? type;
  String? objectId;
  String? title;
  String? notificationId;
  DateTime? created;
  String? avatar;
  String? group;
  String? read;
  ItemNotiUser? user;
  ItemNotiPost? post;
  Mark? mark;
  dynamic feel;

  ItemNotification({
    this.type,
    this.objectId,
    this.title,
    this.notificationId,
    this.created,
    this.avatar,
    this.group,
    this.read,
    this.user,
    this.post,
    this.mark,
    this.feel,
  });

  factory ItemNotification.fromJson(Map<String, dynamic> json) =>
      ItemNotification(
        type: json["type"],
        objectId: json["object_id"],
        title: json["title"],
        notificationId: json["notification_id"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        avatar: json["avatar"],
        group: json["group"],
        read: json["read"],
        user: json["user"] == null ? null : ItemNotiUser.fromJson(json["user"]),
        post: json["post"] == null ? null : ItemNotiPost.fromJson(json["post"]),
        mark: json["mark"] == null ? null : Mark.fromJson(json["mark"]),
        feel: json["feel"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "object_id": objectId,
        "title": title,
        "notification_id": notificationId,
        "created": created?.toIso8601String(),
        "avatar": avatar,
        "group": group,
        "read": read,
        "user": user?.toJson(),
        "post": post?.toJson(),
        "mark": mark?.toJson(),
        "feel": feel,
      };
  String getNotificationTypeText() {
    switch (type) {
      case "1":
        return 'Lời mời kết bạn';
      case "2":
        return 'Đã chấp nhận lời mời kết bạn';
      case "3":
        return 'Đã thêm bài đăng mới';
      case "4":
        return 'Đã cập nhật bài đăng';
      case "5":
        return 'Cảm xúc trên bài đăng';
      case "6":
        return 'Đã đánh dấu bài đăng';
      case "7":
        return 'Bình luận mới';
      case "8":
        return 'Đã thêm video mới';
      case "9":
        return 'Bình luận trên bài đăng';
      default:
        return 'Thông báo không xác định';
    }
  }
}

class Mark {
  String? markId;
  String? typeOfMark;
  String? markContent;

  Mark({
    this.markId,
    this.typeOfMark,
    this.markContent,
  });

  factory Mark.fromJson(Map<String, dynamic> json) => Mark(
        markId: json["mark_id"],
        typeOfMark: json["type_of_mark"],
        markContent: json["mark_content"],
      );

  Map<String, dynamic> toJson() => {
        "mark_id": markId,
        "type_of_mark": typeOfMark,
        "mark_content": markContent,
      };
}

class ItemNotiPost {
  String? id;
  String? described;
  String? status;

  ItemNotiPost({
    this.id,
    this.described,
    this.status,
  });

  factory ItemNotiPost.fromJson(Map<String, dynamic> json) => ItemNotiPost(
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

class ItemNotiUser {
  String? id;
  String? username;
  String? avatar;

  ItemNotiUser({
    this.id,
    this.username,
    this.avatar,
  });

  factory ItemNotiUser.fromJson(Map<String, dynamic> json) => ItemNotiUser(
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
