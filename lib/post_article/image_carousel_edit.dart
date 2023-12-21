// Example: ImageCarouselEdit.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/service/post_sevice.dart';

class ImageCarouselEdit extends StatefulWidget {
  // final List<String> imageUrls;
  final List<XFile?> images;
  final int initialPage;
  final Function(int) onImageRemoved;
  ImageCarouselEdit({
    // required this.imageUrls,
    required this.images,
    required this.initialPage,
    required this.onImageRemoved,
  });

  @override
  _ImageCarouselEditState createState() => _ImageCarouselEditState();
}

class _ImageCarouselEditState extends State<ImageCarouselEdit> {
  late PageController _pageController;

  void _onImageRemoved(removedIndex) {
    widget.onImageRemoved(removedIndex);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: widget.images.map((image) => image!.path).toList().length,
          itemBuilder: (context, index) {
            return Image.file(File(
                widget.images.map((image) => image!.path).toList()[index]));
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              _onImageRemoved(_pageController.page!.toInt());
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
