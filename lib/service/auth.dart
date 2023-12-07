import 'package:dio/dio.dart';
import 'api_service.dart';

Future<void> signUp(String email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    'password': password,
    'uuid': uuid,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('signup', data: request);
  print(response);
}

Future<void> signIn(String email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    'password': password,
    'uuid': uuid,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('login', data: request);
  print("Response đăng nhập");
  print(response);
}

Future<Response> getVerifyCode(String email) async {
  Map<String, dynamic> request = {
    'email': email,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('get_verify_code', data: request);
  return response;
}
