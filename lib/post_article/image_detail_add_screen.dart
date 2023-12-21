import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/post_article/image_carousel_add.dart';

class ImageDetailAddScreen extends StatelessWidget {
  final List<XFile?> images;
  final int initialPage;

  final Function(int, String) onImageRemoved;
  final String? type;
  const ImageDetailAddScreen({
    super.key,
    required this.images,
    required this.initialPage,
    required this.onImageRemoved,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tất cả các ảnh",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: ImageCarouselAdd(
          images: images,
          initialPage: initialPage,
          onImageRemoved: onImageRemoved,
          type: type),
    );
  }
}
