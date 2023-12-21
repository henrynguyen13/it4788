// To parse this JSON data, do
//
//     final ListVideo = ListVideoFromJson(jsonString);

import 'dart:convert';

ListVideo ListVideoFromJson(String str) => ListVideo.fromJson(json.decode(str));

String ListVideoToJson(ListVideo data) => json.encode(data.toJson());

class ListVideo {
  String code;
  String message;
  Data data;

  ListVideo({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ListVideo.fromJson(Map<String, dynamic> json) => ListVideo(
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
  List<Post> post;
  String newItems;
  String lastId;

  Data({
    required this.post,
    required this.newItems,
    required this.lastId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        post: List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        newItems: json["new_items"],
        lastId: json["last_id"],
      );

  Map<String, dynamic> toJson() => {
        "post": List<dynamic>.from(post.map((x) => x.toJson())),
        "new_items": newItems,
        "last_id": lastId,
      };
}

class Post {
  String id;
  String name;
  Video video;
  String described;
  DateTime created;
  String feel;
  String commentMark;
  String isFelt;
  String isBlocked;
  String canEdit;
  String banned;
  String state;
  Author author;

  Post({
    required this.id,
    required this.name,
    required this.video,
    required this.described,
    required this.created,
    required this.feel,
    required this.commentMark,
    required this.isFelt,
    required this.isBlocked,
    required this.canEdit,
    required this.banned,
    required this.state,
    required this.author,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        name: json["name"],
        video: Video.fromJson(json["video"]),
        described: json["described"],
        created: DateTime.parse(json["created"]),
        feel: json["feel"],
        commentMark: json["comment_mark"],
        isFelt: json["is_felt"],
        isBlocked: json["is_blocked"],
        canEdit: json["can_edit"],
        banned: json["banned"],
        state: json["state"],
        author: Author.fromJson(json["author"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "video": video.toJson(),
        "described": described,
        "created": created.toIso8601String(),
        "feel": feel,
        "comment_mark": commentMark,
        "is_felt": isFelt,
        "is_blocked": isBlocked,
        "can_edit": canEdit,
        "banned": banned,
        "state": state,
        "author": author.toJson(),
      };
}

class Author {
  String id;
  String name;
  String avatar;

  Author({
    required this.id,
    required this.name,
    required this.avatar,
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
  String url;

  Video({
    required this.url,
  });

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
