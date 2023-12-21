import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class EditPostDto {
  final String id;
  final String? described;
  final List<int>? imageSort;
  final List<String?>? imageDel;
  final List<XFile?> images;
  final XFile? video;

  EditPostDto({
    required this.id,
    this.described,
    this.imageSort,
    this.imageDel,
    required this.images,
    this.video,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'described': described,
        'status': 'Hyped',
        // 'image_sort': imageSort,
        'image_del': imageDel!.join(','),
        'auto_accept': '1',
        'video': video
      };
}

// To parse this JSON data, do
//
//     final editPostResponse = editPostResponseFromJson(jsonString);

EditPostResponse editPostResponseFromJson(String str) =>
    EditPostResponse.fromJson(json.decode(str));

String editPostResponseToJson(EditPostResponse data) =>
    json.encode(data.toJson());

class EditPostResponse {
  String code;
  String message;
  Data data;

  EditPostResponse({
    required this.code,
    required this.message,
    required this.data,
  });

  factory EditPostResponse.fromJson(Map<String, dynamic> json) =>
      EditPostResponse(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  String coins;

  Data({
    required this.id,
    required this.coins,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        coins: json["coins"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "coins": coins,
      };
}
