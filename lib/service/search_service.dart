import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/service/api_service.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/post_sevice.dart';

class SearchService {
  Future<Response> getUserInfor(
      String keyword, String index, String count) async {
    try {
      Map<String, dynamic> request = {
        "keyword": keyword,
        "index": index,
        "count": count
      };
      final dio = ApiService.createDio();
      final response = await dio.post(
        'search_user',
        data: request,
      );
      print(response.data);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> searchPost(
      String keyword, String userId, int index, int count) async {
    var token = await Storage().getToken();

    Map<String, dynamic> request = {
      'keyword': keyword,
      //'user_id': userId,
      'index': index,
      'count': count,
    };
    final dio = ApiService.createDio();
    final response = await dio.post('search',
        data: request,
        options: Options(headers: {"Authorization": "Bearer $token"}));

    final jsonResponse = json.decode(response.data);
    final postListJson = jsonResponse['data'];

    List<String> postIdlist = <String>[];
    for (int i = 0; i < postListJson.length; i++) {
      postIdlist.add(postListJson[i]['id']);
    }

    return postIdlist;
  }
}
