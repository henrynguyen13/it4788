import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  static Dio createDio() {
    return Dio(
      BaseOptions(
        baseUrl: 'https://it4788.catan.io.vn/',
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {
          HttpHeaders.userAgentHeader: 'dio',
          'api': '1.0.0',
        },
        contentType: Headers.jsonContentType,
        responseType: ResponseType.plain,
      ),
    );
  }
}
