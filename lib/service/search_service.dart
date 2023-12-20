import 'package:dio/dio.dart';
import 'package:it4788/service/api_service.dart';

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
}
