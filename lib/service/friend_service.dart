import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/service/authStorage.dart';

import 'api_service.dart';

class FriendService {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<UserFriends?> getFriendRequest(int count) async {
    UserFriends userFriends;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {'index': 0, 'count': count};
      final dio = ApiService.createDio();
      final response = await dio.post('get_requested_friends',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      userFriends = userFriendsFromJson(response.data);
      print(response.data);
      return userFriends;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
