// Example: ImageListScreen.dart
import 'package:flutter/material.dart';
import 'package:it4788/post_article/image_carousel.dart';

class ImageDetailScreen extends StatelessWidget {
  final List<String> imageUrls;
  final int initialPage;
  final Function(int) onImageRemoved;
  const ImageDetailScreen({
    required this.imageUrls,
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
      body: ImageCarousel(
        imageUrls: imageUrls,
        initialPage: initialPage,
        onImageRemoved: onImageRemoved,
      ),
    );
  }
}
