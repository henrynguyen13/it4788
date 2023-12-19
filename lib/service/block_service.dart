import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:it4788/model/blocked_user.dart';
import 'package:it4788/service/api_service.dart';
import 'package:it4788/service/authStorage.dart';

Future<Response> setBlock(int userID) async {
  var token = await Storage().getToken();
  Map<String, dynamic> request = {'user_id': userID};
  final dio = ApiService.createDio();
  final response = await dio.post('set_block',
      data: request,
      options: Options(headers: {"Authorization": "Bearer $token"}));
  return response;
}

Future<Response> setUnBlock(int userID) async {
  var token = await Storage().getToken();
  Map<String, dynamic> request = {'user_id': userID};
  final dio = ApiService.createDio();
  final response = await dio.post('unblock',
      data: request,
      options: Options(headers: {"Authorization": "Bearer $token"}));
  return response;
}

Future<List<BlockedUser>> getBlockList(int index, int count) async {
  var token = await Storage().getToken();
  Map<String, dynamic> request = {'index': index, 'count': count};
  final dio = ApiService.createDio();
  final response = await dio.post('get_list_blocks',
      data: request,
      options: Options(headers: {"Authorization": "Bearer $token"}));

  List<BlockedUser> blockList = <BlockedUser>[];
  final jsonResponse = json.decode(response.data);

  if (jsonResponse['message'] == "OK") {
    final blockListString = jsonResponse['data'];

    for (int i = 0; i < blockListString.length; i++) {
      blockList.add(BlockedUser(
          userID: blockListString[i]['id'],
          name: blockListString[i]['name'],
          avatar: blockListString[i]['avatar']));
    }

    return blockList;
  } else {
    return blockList;
  }
}
