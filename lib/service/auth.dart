import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:it4788/service/authStorage.dart';
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

Future<Response> signIn(String email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    'password': password,
    'uuid': uuid,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('login', data: request);

  // lưu thông tin token vào storage
  final jsonResponse = json.decode(response.data);
  String token = jsonResponse['data']['token'];
  await Storage().saveToken(token);

  // Lấy ra token
  String? storedToken = await Storage().getToken();
  print('Token from storage: $storedToken');

  return response;
}

Future<Response> getVerifyCode(String email) async {
  Map<String, dynamic> request = {
    'email': email,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('get_verify_code', data: request);

  // lưu thông tin verify code vào storage
  final jsonResponse = json.decode(response.data);
  print(response.data);
  String verifyCode = jsonResponse['data']['verify_code'];
  await Storage().saveVerifyCode(verifyCode);

  return response;
}

Future<Response> checkVerifyCode(String email, String verifyCode) async {
  Map<String, dynamic> request = {'email': email, 'code_verify': verifyCode};
  final dio = ApiService.createDio();
  final response = await dio.post('check_verify_code', data: request);
  print('Xác nhận verify code thành công !');
  return response;
}
