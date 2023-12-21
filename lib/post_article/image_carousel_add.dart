import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCarouselAdd extends StatefulWidget {
  final List<XFile?> images;
  final int initialPage;
  final Function(int, String) onImageRemoved;
  String? type;
  ImageCarouselAdd(
      {required this.images,
      required this.initialPage,
      required this.onImageRemoved,
      required this.type});

  @override
  _ImageCarouselAddState createState() => _ImageCarouselAddState();
}

class _ImageCarouselAddState extends State<ImageCarouselAdd> {
  late PageController _pageController;

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
