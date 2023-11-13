import 'package:flutter/material.dart';

class Article {
  Article(
      {required this.id,
      // required this.name,
      required this.image,
      required this.described,
      required this.created,
      required this.feel,
      required this.kudos,
      required this.disappointed,
      required this.author});
  final String id;
  // final String name;
  final List<String> image;
  final String described;
  final DateTime created;
  final int feel;
  final int disappointed;
  final int kudos;
  final Author author;
}

class Author {
  Author({
    required this.authorId,
    required this.username,
    required this.avatar,
  });

  final String authorId;
  final String username;
  final String avatar;
}
