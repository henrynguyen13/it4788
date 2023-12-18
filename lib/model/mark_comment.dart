class Mark {
  String id;
  String markContent;
  String typeOfMark;
  String createdTime;
  Poster poster;
  List<Comment> comments;

  Mark(
      {required this.id,
      required this.markContent,
      required this.typeOfMark,
      required this.createdTime,
      required this.poster,
      required this.comments});
}

class Comment {
  String commentContent;
  String createdTime;
  Poster poster;

  Comment(
      {required this.commentContent,
      required this.createdTime,
      required this.poster});
}

class Poster {
  String id;
  String name;
  String avatar;

  Poster({required this.id, required this.name, required this.avatar});
}
