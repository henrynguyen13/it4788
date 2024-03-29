import 'package:dio/dio.dart';
import 'package:it4788/model/request_friends.dart';
import 'package:it4788/model/suggest_friends.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/service/authStorage.dart';

import 'api_service.dart';

class FriendService {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<RequestFriendList?> getFriendRequest(int index, int count) async {
    RequestFriendList requestFriends;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {'index': index, 'count': count};
      final dio = ApiService.createDio();
      final response = await dio.post('get_requested_friends',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      requestFriends = requestFriendsFromJson(response.data);
      print(response.data);
      return requestFriends;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<SuggestedFriendList?> getSuggestFriend(int index, int count) async {
    SuggestedFriendList suggestedFriendList;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {'index': index, 'count': count};
      final dio = ApiService.createDio();
      final response = await dio.post('get_suggested_friends',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      suggestedFriendList = suggestedFriendListFromJson(response.data);
      print(response.data);
      return suggestedFriendList;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> setAcceptFriend(String id) async {
    var token = await _getToken();
    try {
      Map<String, dynamic> request = {
        'user_id': id,
        'is_accept': "1",
      };
      final dio = ApiService.createDio();
      final response = await dio.post('set_accept_friend',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> setRequestFriend(String id) async {
    var token = await _getToken();
    try {
      Map<String, dynamic> request = {
        'user_id': id,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('set_request_friend',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> setDeleteFriend(String id) async {
    var token = await _getToken();
    try {
      Map<String, dynamic> request = {
        'user_id': id,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('del_request_friend',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> unFriend(String id) async {
    var token = await _getToken();
    try {
      Map<String, dynamic> request = {
        'user_id': id,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('unfriend',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
