import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:it4788/model/mark_comment.dart';
import 'package:it4788/service/api_service.dart';
import 'package:it4788/service/authStorage.dart';

Future<List<Mark>> setMark(String postId, String content, String index,
    String count, String markType) async {
  var token = await Storage().getToken();
  Map<String, dynamic> request = {
    'id': postId,
    'content': content,
    'index': index,
    'count': count,
    //'mark_id': "",
    'type': markType,
  };

  final dio = ApiService.createDio();
  final response = await dio.post('set_mark_comment',
      data: request,
      options: Options(headers: {"Authorization": "Bearer $token"}));

  return commentResponseHandler(response);
}

Future<List<Mark>> setComment(String postId, String content, String index,
    String count, String markId) async {
  var token = await Storage().getToken();

  Map<String, dynamic> request = {
    'id': postId,
    'content': content,
    'index': index,
    'count': count,
    'mark_id': markId,
    'type': "",
  };
  final dio = ApiService.createDio();
  final response = await dio.post('set_mark_comment',
      data: request,
      options: Options(headers: {"Authorization": "Bearer $token"}));

  return commentResponseHandler(response);
}

Future<List<Mark>> getMarkComment(
    String postId, String index, String count) async {
  var token = await Storage().getToken();
  Map<String, dynamic> request = {
    'id': postId,
    'index': index,
    'count': count,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('get_mark_comment',
      data: request,
      options: Options(headers: {"Authorization": "Bearer $token"}));

  return commentResponseHandler(response);
}

List<Mark> commentResponseHandler(Response response) {
  final jsonResponse = json.decode(response.data);
  final markListString = jsonResponse['data'];
  List<Mark> markList = <Mark>[];
  print("MarkListString: ${markListString}");

  for (int i = 0; i < markListString.length; i++) {
    final comments = markListString[i]['comments'];
    List<Comment> commentList = <Comment>[];
    for (int j = 0; j < comments.length; j++) {
      final poster = comments[j]['poster'];
      Comment newComment = Comment(
          commentContent: comments[j]['content'],
          createdTime: comments[j]['created'],
          poster: Poster(
              id: poster['id'],
              name: poster['name'],
              avatar: poster['avatar']));
      commentList.add(newComment);
    }

    final markPoster = markListString[i]['poster'];
    Mark newMark = Mark(
        id: markListString[i]['id'],
        markContent: markListString[i]['mark_content'],
        typeOfMark: markListString[i]['type_of_mark'],
        createdTime: markListString[i]['created'],
        poster: Poster(
            id: markPoster['id'],
            name: markPoster['name'],
            avatar: markPoster['avatar']),
        comments: commentList);
    markList.add(newMark);
  }

  return markList;
}
