import 'dart:convert';

PostDraft postDraftFromJson(String str) => PostDraft.fromJson(json.decode(str));

String postDraftToJson(PostDraft data) => json.encode(data.toJson());

class PostDraft {
  String? postContent;

  PostDraft({
    this.postContent,
  });

  factory PostDraft.fromJson(Map<String, dynamic> json) => PostDraft(
        postContent: json["postContent"],
      );

  Map<String, dynamic> toJson() => {
        "postContent": postContent,
      };
}
