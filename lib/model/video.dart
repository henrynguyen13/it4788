// To parse this JSON data, do
//
//     final listVideo = listVideoFromJson(jsonString);

import 'dart:convert';

ListVideo listVideoFromJson(String str) => ListVideo.fromJson(json.decode(str));

String listVideoToJson(ListVideo data) => json.encode(data.toJson());

class ListVideo {
  String? code;
  String? message;
  Data? data;

  ListVideo({
    this.code,
    this.message,
    this.data,
  });

  factory ListVideo.fromJson(Map<String, dynamic> json) => ListVideo(
        code: json["code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  List<PostVideo>? post;
  String? newItems;
  String? lastId;

  Data({
    this.post,
    this.newItems,
    this.lastId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        post: json["post"] == null
            ? []
            : List<PostVideo>.from(
                json["post"]!.map((x) => PostVideo.fromJson(x))),
        newItems: json["new_items"],
        lastId: json["last_id"],
      );

  Map<String, dynamic> toJson() => {
        "post": post == null
            ? []
            : List<dynamic>.from(post!.map((x) => x.toJson())),
        "new_items": newItems,
        "last_id": lastId,
      };
}

class PostVideo {
  String? id;
  String? name;
  Video? video;
  String? described;
  DateTime? created;
  String? feel;
  String? commentMark;
  String? isFelt;
  String? isBlocked;
  String? canEdit;
  String? banned;
  String? state;
  Author? author;

  PostVideo({
    this.id,
    this.name,
    this.video,
    this.described,
    this.created,
    this.feel,
    this.commentMark,
    this.isFelt,
    this.isBlocked,
    this.canEdit,
    this.banned,
    this.state,
    this.author,
  });

  factory PostVideo.fromJson(Map<String, dynamic> json) => PostVideo(
        id: json["id"],
        name: json["name"],
        video: json["video"] == null ? null : Video.fromJson(json["video"]),
        described: json["described"],
        created:
            json["created"] == null ? null : DateTime.parse(json["created"]),
        feel: json["feel"],
        commentMark: json["comment_mark"],
        isFelt: json["is_felt"],
        isBlocked: json["is_blocked"],
        canEdit: json["can_edit"],
        banned: json["banned"],
        state: json["state"],
        author: json["author"] == null ? null : Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "video": video?.toJson(),
        "described": described,
        "created": created?.toIso8601String(),
        "feel": feel,
        "comment_mark": commentMark,
        "is_felt": isFelt,
        "is_blocked": isBlocked,
        "can_edit": canEdit,
        "banned": banned,
        "state": state,
        "author": author?.toJson(),
      };
}

class Author {
  String? id;
  String? name;
  String? avatar;

  Author({
    this.id,
    this.name,
    this.avatar,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        name: json["name"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar,
      };
}

class Video {
  String? url;

  Video({
    this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
