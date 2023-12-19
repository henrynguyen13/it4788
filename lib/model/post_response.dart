// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/post.dart';

PostResponse postResponseFromJson(String str) =>
    PostResponse.fromJson(json.decode(str));

String postResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  String code;
  String message;
  Data data;

  PostResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
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
  String name;
  DateTime created;
  String described;
  String modified;
  String fake;
  String trust;
  String kudos;
  String disappointed;
  String isFelt;
  String isMarked;
  List<PostImage> image;
  Author author;
  Category category;
  String state;
  String isBlocked;
  String canEdit;
  String banned;
  String canMark;
  String canRate;
  String url;
  String messages;

  Data({
    required this.id,
    required this.name,
    required this.created,
    required this.described,
    required this.modified,
    required this.fake,
    required this.trust,
    required this.kudos,
    required this.disappointed,
    required this.isFelt,
    required this.isMarked,
    required this.image,
    required this.author,
    required this.category,
    required this.state,
    required this.isBlocked,
    required this.canEdit,
    required this.banned,
    required this.canMark,
    required this.canRate,
    required this.url,
    required this.messages,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        created: DateTime.parse(json["created"]),
        described: json["described"],
        modified: json["modified"],
        fake: json["fake"],
        trust: json["trust"],
        kudos: json["kudos"],
        disappointed: json["disappointed"],
        isFelt: json["is_felt"],
        isMarked: json["is_marked"],
        image: List<PostImage>.from(
            json["image"].map((x) => PostImage.fromJson(x))),
        author: Author.fromJson(json["author"]),
        category: Category.fromJson(json["category"]),
        state: json["state"],
        isBlocked: json["is_blocked"],
        canEdit: json["can_edit"],
        banned: json["banned"],
        canMark: json["can_mark"],
        canRate: json["can_rate"],
        url: json["url"],
        messages: json["messages"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created": created.toIso8601String(),
        "described": described,
        "modified": modified,
        "fake": fake,
        "trust": trust,
        "kudos": kudos,
        "disappointed": disappointed,
        "is_felt": isFelt,
        "is_marked": isMarked,
        "image": List<PostImage>.from(image.map((x) => x.toJson())),
        "author": author.toJson(),
        "category": category.toJson(),
        "state": state,
        "is_blocked": isBlocked,
        "can_edit": canEdit,
        "banned": banned,
        "can_mark": canMark,
        "can_rate": canRate,
        "url": url,
        "messages": messages,
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

class Category {
  String id;
  String hasName;
  String name;

  Category({
    required this.id,
    required this.hasName,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        hasName: json["has_name"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "has_name": hasName,
        "name": name,
      };
}

class PostImage {
  String id;
  String url;

  PostImage({
    required this.id,
    required this.url,
  });

  factory PostImage.fromJson(Map<String, dynamic> json) => PostImage(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
