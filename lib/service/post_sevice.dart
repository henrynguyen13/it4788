import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/model/user_model.dart';

import 'api_service.dart';

class PostSevice {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NjY4LCJkZXZpY2VfaWQiOiJzdHJpbmciLCJpYXQiOjE3MDIzNTE1MDF9.42M9IQqlICxzTIf59FA6nBscj1bFdCc1v7bJYkW-keI";

  Future<ListPost?> getPostList(String id) async {
    ListPost listPost;

    try {
      Map<String, dynamic> request = {
        "index": 0,
        'count': 50,
        'last_id': 0,
        "in_campaign": "1",
        "campaign_id": "1",
        "latitude": "1.0",
        "longitude": "1.0",
      };
      final dio = ApiService.createDio();
      final response = await dio.post('get_list_posts',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      listPost = listPostFromJson(response.data);
      print(response.data);
      return listPost;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> feelPost(String id, String type) async {
    try {
      Map<String, dynamic> request = {
        'id': id,
        'type': type,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('feel',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> deleteFeelPost(String id) async {
    try {
      Map<String, dynamic> request = {
        'id': id,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('delete_feel',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
