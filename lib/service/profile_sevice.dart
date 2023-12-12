import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/model/user_model.dart';
import 'package:it4788/service/authStorage.dart';

import 'api_service.dart';

class ProfileSevice {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<UserInfor?> getUserInfor(String id) async {
    var token = await _getToken();
    UserInfor? userInfor;

    try {
      Map<String, dynamic> request = {
        'user_id': id,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('get_user_info',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      userInfor = userInforFromJson(response.data);
      print(response.data);
      return userInfor;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<UserFriends?> getUserFriend(String id, int count) async {
    UserFriends userFriends;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {
        'index': 0,
        'user_id': id,
        'count': count
      };
      final dio = ApiService.createDio();
      final response = await dio.post('get_user_friends',
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

  Future<List<dynamic>> getDataForPersonalPage(String id) async {
    try {
      List<Future<dynamic>> futures = [
        getUserInfor(id),
        getUserFriend(id, 6),
        getMyListPost(id)
      ];

      Future<List<dynamic>> results = Future.wait(futures);

      return results;
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> setUserInfor(
      String username,
      String description,
      File? avatar,
      String address,
      String city,
      String country,
      File? coverImage,
      String link) async {
    try {
      var token = await _getToken();
      String avatarName = "";
      String coverImageName = "";
      if (avatar != null) avatarName = avatar.path.split('/').last;
      if (coverImage != null) coverImageName = coverImage.path.split('/').last;

      FormData formData = FormData.fromMap({
        'username': username,
        'description': description,
        'address': address,
        "city": city,
        "country": country,
        "link": link,
        "avatar": avatarName.isNotEmpty && avatar != null
            ? await MultipartFile.fromFile(avatar.path,
                filename: avatarName, contentType: MediaType("image", "jpeg"))
            : "",
        "cover_image": coverImageName.isNotEmpty && coverImage != null
            ? await MultipartFile.fromFile(
                coverImage.path,
                filename: coverImageName,
                contentType: MediaType("image", "jpeg"),
              )
            : "",
      });
      final dio = ApiService.createDio();
      final response = await dio.post('set_user_info',
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      print(response.data);
      return;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<ListPost?> getMyListPost(String id) async {
    ListPost listPost;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {
        'user_id': id,
        'count': 50,
        'last_id': 0,
        'in_campaign': 1,
        'campaign_id': 1,
        'latitude': 1.0,
        'longitude': 1.0,
        'index': 0
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
    var token = await _getToken();
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
    var token = await _getToken();
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
