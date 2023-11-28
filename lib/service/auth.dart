import 'package:dio/dio.dart';
import 'api_service.dart';

Future<void> signUp(String email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    'password': password,
    'uuid': uuid,
  };
  print('khoa');

  final dio = ApiService.createDio();
  final response = await dio.post('signup', data: request);
  print(response);
}
