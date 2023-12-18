import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/service/authStorage.dart';
import 'api_service.dart';

class PostSevice {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<ListPost?> getPostList(int index, int count) async {
    ListPost listPost;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {
        "index": index,
        'count': count,
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

  Future<Response> addPost(List<XFile?> images, File? video, String described,
      String status, String auto_accept) async {
    try {
      var token = await _getToken();

      FormData formData = FormData();

      for (XFile? image in images) {
        if (image != null) {
          File file = File(image.path);
          formData.files.add(MapEntry(
              'image',
              (await MultipartFile.fromFile(file.path,
                  filename: file.path.split('/').last,
                  contentType: MediaType("image", "jpeg")))));
        }
      }
      if (video != null) {
        formData.files.add(MapEntry(
            'video',
            (await MultipartFile.fromFile(video.path,
                filename: video.path.split('/').last,
                contentType: MediaType("video", "mp4")))));
      }

      formData.fields.add(MapEntry('described', described));

      formData.fields.add(MapEntry('status', status));

      formData.fields.add(MapEntry('auto_accept', auto_accept));

      final dio = ApiService.createDio();
      final response = await dio.post('add_post',
          data: formData,
          options: Options(headers: {
            "Authorization": "Bearer $token",
          }));

      print(response.data);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
