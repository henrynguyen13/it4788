// Example: ImageListScreen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/post_article/image_carousel.dart';
import 'package:it4788/post_article/image_carousel_edit.dart';

class ImageDetailEditScreen extends StatelessWidget {
  final List<XFile?> images;
  // final List<String> imageIndex;
  final int initialPage;
  final Function(int) onImageRemoved;
  const ImageDetailEditScreen({
    required this.images,
    required this.initialPage,
    required this.onImageRemoved,
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
      body: ImageCarouselEdit(
        // imageUrls: imageUrls,
        images: images,
        initialPage: initialPage,
        onImageRemoved: onImageRemoved,
      ),
    );
  }
}
