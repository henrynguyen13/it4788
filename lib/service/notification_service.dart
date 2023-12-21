import 'package:dio/dio.dart';
import 'package:it4788/model/notification_list.dart';
import 'package:it4788/service/api_service.dart';
import 'package:it4788/service/authStorage.dart';

class NotificationService {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<ListNotification?> getNotiList(int index, int count) async {
    ListNotification listNotification;
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {
        "index": index,
        'count': count,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('get_notification',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));
      print("BUGGGG ${response.data}");
      listNotification = listNotificationFromJson(response.data);
      return listNotification;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
