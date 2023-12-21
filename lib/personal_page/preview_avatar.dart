import 'dart:io';

import 'package:flutter/material.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/service/profile_sevice.dart';

class PreviewAvatar extends StatefulWidget {
  final String imagePath;
  final UserInfor userInfor;

  const PreviewAvatar(
      {Key? key, required this.imagePath, required this.userInfor})
      : super(key: key);

  @override
  State<PreviewAvatar> createState() => _PreviewAvatarState();
}

class _PreviewAvatarState extends State<PreviewAvatar> {
  void popBackScreen() {
    Navigator.pop(context);
  }

  void saveImage() async {
    File imageFile = File(widget.imagePath);

    await ProfileSevice().setUserInfor(
        widget.userInfor.data.username,
        widget.userInfor.data.description,
        imageFile,
        widget.userInfor.data.address,
        widget.userInfor.data.city,
        widget.userInfor.data.country,
        null,
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
          child: CircleAvatar(
            radius: 200,
            backgroundImage: FileImage(File(widget.imagePath)),
          ),
        ));
  }
}
