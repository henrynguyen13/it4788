class PostDraft {
  late List<String> images;
  // late String video;
  late String postContent;
  late String status;
  late String autoAccept;

  PostDraft(
    List<dynamic> images,
    // String video,
    String postContent,
    String status,
    String autoAccept,
  ) {
    this.images = images.cast<String>();
  }

  factory PostDraft.fromJson(Map<String, dynamic> json) {
    return PostDraft(
      json['images'] as List<dynamic>,
      // json['video'] as String,
      json['postContent'] as String,
      json['status'] as String,
      json['autoAccept'] as String,
    );
  }

  toJson() => {
        'images': images.cast<dynamic>(),
        // 'video': video,
        'postContent': postContent,
        'status': status,
        'autoAccept': autoAccept
      };

  toPrint() {
    print('post content: $postContent');
  }
}
