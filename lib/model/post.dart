import 'dart:convert';

ListPost listPostFromJson(String str) => ListPost.fromJson(json.decode(str));
Post postDetailFromJson(String str) => Post.fromJson(json.decode(str));

String listPostToJson(ListPost data) => json.encode(data.toJson());

class ListPost {
  String code;
  String message;
  Data data;

  ListPost({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ListPost.fromJson(Map<String, dynamic> json) => ListPost(
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
  List<ImagePost> image;
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
    required this.image,
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
        image: List<ImagePost>.from(
            json["image"].map((x) => ImagePost.fromJson(x))),
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
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
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

class ImagePost {
  String id;
  String url;

  ImagePost({
    required this.id,
    required this.url,
  });

  factory ImagePost.fromJson(Map<String, dynamic> json) => ImagePost(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
