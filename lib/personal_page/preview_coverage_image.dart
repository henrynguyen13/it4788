import 'dart:io';

import 'package:flutter/material.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/service/profile_sevice.dart';

class PreviewCoverageImage extends StatefulWidget {
  final String imagePath;
  final UserInfor userInfor;

  const PreviewCoverageImage(
      {Key? key, required this.imagePath, required this.userInfor})
      : super(key: key);

  @override
  State<PreviewCoverageImage> createState() => _PreviewCoverageImageState();
}

class _PreviewCoverageImageState extends State<PreviewCoverageImage> {
  void popBackScreen() {
    Navigator.pop(context);
  }

  void saveImage() async {
    File imageFile = File(widget.imagePath);
    await ProfileSevice().setUserInfor(
        widget.userInfor.data.username,
        widget.userInfor.data.description,
        null,
        widget.userInfor.data.address,
        widget.userInfor.data.city,
        widget.userInfor.data.country,
        imageFile,
        widget.userInfor.data.link);
    popBackScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Xem trước ảnh'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            tooltip: 'Save image',
            onPressed: () {
              saveImage();
            },
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20), // Image border
              child: SizedBox(
                width: double.infinity,
                height: 400, // Image radius
                child: Image(
                  image: FileImage(File(widget.imagePath)),
                  fit: BoxFit.cover,
                ),
              ))),
    );
  }
}
