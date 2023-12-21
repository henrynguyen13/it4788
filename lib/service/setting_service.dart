import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it4788/service/api_service.dart';
import 'package:it4788/service/authStorage.dart';

class SettingService {
  Future<String?> _getToken() async {
    return await Storage().getToken();
  }

  Future<Response> buyCoins(String code, String coins) async {
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {
        'code': code,
        'coins': coins,
      };
      final dio = ApiService.createDio();
      final response = await dio.post('buy_coins',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      print("RESPONSE ${response.data}");
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> changePassword(
      String currentPassword, String newPassword) async {
    var token = await _getToken();

    try {
      Map<String, dynamic> request = {
        'password': "123456",
        'new_password': "123456",
      };
      final dio = ApiService.createDio();
      final response = await dio.post('change_password',
          data: request,
          options: Options(headers: {"Authorization": "Bearer $token"}));

      print("RESPONSE ${response.statusCode} - ${response.data}");
      return response;
    } catch (e) {
      print("ERROR: $e");
      rethrow;
    }
  }
}
