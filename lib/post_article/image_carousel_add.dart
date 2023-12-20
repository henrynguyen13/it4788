// Example: ImageCarousel.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/service/post_sevice.dart';

class ImageCarouselAdd extends StatefulWidget {
  // final List<String> imageUrls;
  final List<XFile?> images;
  final int initialPage;
  final Function(int, String) onImageRemoved;
  ImageCarouselAdd({
    // required this.imageUrls,
    required this.images,
    required this.initialPage,
    required this.onImageRemoved,
  });

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
            return Image.network(
                widget.images.map((image) => image!.path).toList()[index]);
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
              child: Icon(
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
