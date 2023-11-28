import 'package:dio/dio.dart';

signUp(String email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    "password": password,
    "uuid": uuid
  };
  print('khoa');

  final dio = Dio();
  final response =
      await dio.post('https://it4788.catan.io.vn/signup', data: request);
  print(response);
}
