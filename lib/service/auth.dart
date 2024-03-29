import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:it4788/service/authStorage.dart';
import 'api_service.dart';

Future<String?> _getToken() async {
  return await Storage().getToken();
}

Future<Response> signUp(String email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    'password': password,
    'uuid': uuid,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('signup', data: request);
  return response;
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
  String userId = jsonResponse['data']['id'].toString();

  Storage().saveUserId(userId);
  Storage().saveToken(jsonResponse['data']['token']);
  Storage().saveUsername(jsonResponse['data']['username']);
  Storage().saveAvatar(jsonResponse['data']['avatar']).toString();
  Storage().saveCoins(jsonResponse['data']['coins']);

  return response;
}

Future<Response> logOut() async {
  try {
    var token = await _getToken();

    final dio = ApiService.createDio();
    final response = await dio.post('logout',
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }));
    return response;
  } catch (e) {
    throw e;
  }
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

  Storage().saveVerifyCode(verifyCode);

  return response;
}

Future<Response> checkVerifyCode(String email, String verifyCode) async {
  Map<String, dynamic> request = {'email': email, 'code_verify': verifyCode};
  final dio = ApiService.createDio();
  final response = await dio.post('check_verify_code', data: request);
  print('Xác nhận verify code thành công !');
  return response;
}

Future<Response> setUsername(String username, File? avatar) async {
  var token = await _getToken();
  FormData formData = FormData.fromMap({
    'username': username,
    'avatar': avatar != null
        ? MultipartFile.fromFile(avatar.path,
            filename: avatar.path.split('/').last)
        : ""
  });
  final dio = ApiService.createDio();
  final response = await dio.post('change_profile_after_signup',
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}));

  final jsonResponse = json.decode(response.data);
  Storage().saveUsername(jsonResponse['data']['username']);
  Storage().saveAvatar(jsonResponse['data']['avatar']).toString();
  print('Bạn đã đặt tên thành công !');
  return response;
}

Future<bool> emailIsExisted(String email) async {
  Map<String, dynamic> request = {
    'email': email,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('check_email', data: request);

  final jsonResponse = json.decode(response.data);
  String isExisted = jsonResponse['data']['existed'];

  return isExisted == "1";
}

Future<Response> resetPassword(
    String email, String verifyCode, String password) async {
  Map<String, dynamic> request = {
    'email': email,
    'code': verifyCode,
    'password': password
  };

  final dio = ApiService.createDio();
  final response = await dio.post('reset_password', data: request);

  return response;
}
