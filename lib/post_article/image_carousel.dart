// Example: ImageCarousel.dart
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final int initialPage;
  final Function(int) onImageRemoved;
  ImageCarousel({
    required this.imageUrls,
    required this.initialPage,
    required this.onImageRemoved,
  });

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;

  void _onImageRemoved(int removedIndex) {
    // Call the callback function to remove the current image
    widget.onImageRemoved(removedIndex);

    // Close the image list screen
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
          itemCount: widget.imageUrls.length,
          itemBuilder: (context, index) {
            return Image.network(widget.imageUrls[index]);
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              _onImageRemoved(_pageController.page!.toInt());
            },
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
