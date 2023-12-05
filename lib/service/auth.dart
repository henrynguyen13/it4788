import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it4788/welcome.dart';

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

Future<bool> signIn(email, String password, String uuid) async {
  Map<String, dynamic> request = {
    'email': email,
    'password': password,
    'uuid': uuid,
  };
  final dio = ApiService.createDio();
  final response = await dio.post('signin', data: request);
  print('response');
  print(response);
  return response.statusCode == 200;
}
