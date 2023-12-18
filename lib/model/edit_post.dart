import 'dart:io';

import 'package:dio/dio.dart';

class EditPostDto {
  final String id;
  final String? described;
  final List<int>? imageSort;
  final List<int>? imageDel;
  final List<File>? images;
  final File? video;

  EditPostDto({
    required this.id,
    this.described,
    this.imageSort,
    this.imageDel,
    this.images,
    this.video,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'described': described,
        'status': 'Hyped',
        // 'image_sort': imageSort,
        // 'image_del': imageDel,
        'auto_accept': '1',
        'image': images?.map((e) => e.path.split('/').last).toList(),
        'video': video?.path.split('/').last,
      };
}

class EditPostResponse {
  final String id;
  final String coins;

  EditPostResponse({
    required this.id,
    required this.coins,
  });
}
