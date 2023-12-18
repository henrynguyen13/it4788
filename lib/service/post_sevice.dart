import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:it4788/model/edit_post.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/service/authStorage.dart';

import 'api_service.dart';

class PostSevice {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<ListPost?> getPostList(String id) async {
    ListPost listPost;
    var token = await _getToken();

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

  Future<void> addPost() async {
    try {} catch (e) {}
  }

  Future<PostResponse> getPostById(String id) async {
    var token = await _getToken();
    PostResponse postResponse;

    try {
      Map<String, dynamic> request = {
        'id': id,
      };

      final dio = ApiService.createDio();
      final response = await dio.post('get_post',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print(response.data);
      postResponse = postResponseFromJson(response.data);
      return postResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<EditPostResponse> editPost(EditPostDto postDto) async {
    try {
      var token = await _getToken();

      FormData formData = FormData.fromMap(postDto.toJson());

      if (postDto.images != null) {
        for (int i = 0; i < postDto.images!.length; i++) {
          File imageFile = postDto.images![i];
          if (imageFile.existsSync()) {
            formData.files.add(MapEntry(
              'image',
              await MultipartFile.fromFile(
                imageFile.path,
                filename: 'image$i',
                contentType: MediaType('image', 'jpeg'),
              ),
            ));
          } else {
            print('Image file $i does not exist.');
          }
        }
      }

      if (postDto.video != null) {
        File videoFile = postDto.video!;
        if (videoFile.existsSync()) {
          formData.files.add(MapEntry(
            'video',
            MultipartFile.fromBytes(
              await videoFile.readAsBytes(),
              filename: 'video',
              contentType: MediaType('video', 'mp4'),
            ),
          ));
        } else {
          print('Video file does not exist.');
        }
      }
      final dio = ApiService.createDio();
      final response = await dio.post('edit_post',
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
