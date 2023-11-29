import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/model/user_model.dart';

import 'api_service.dart';

class ProfileAPI {
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTkzLCJkZXZpY2VfaWQiOiJzc3NzIiwiaWF0IjoxNzAxMjQ1NTUzfQ.41Df22_jnTTx-f7lFkGNxTMW6rWgfogGyW3AOTQY-Xs";

  Future<UserInfor?> getUserInfor(String id) async {
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

  Future<UserFriends?> getUserFriend(String id) async {
    UserFriends userFriends;

    try {
      Map<String, dynamic> request = {'index': 0, 'user_id': id, 'count': 10};
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
        getUserFriend(id),
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
            ? await MultipartFile.fromFile(
                avatar.path,
                filename: avatarName,
              )
            : "",
        "cover_image": coverImageName.isNotEmpty && coverImage != null
            ? await MultipartFile.fromFile(
                coverImage.path,
                filename: coverImageName,
                contentType: MediaType("image", "jpeg"),
              )
            : "",
      });

      print("FORRMMMMMMMM + ${formData.toString()}");
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
}
