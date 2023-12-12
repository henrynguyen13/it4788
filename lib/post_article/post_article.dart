import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/post_article/feelings_activities/feelings_activities_picker.dart';

class PostArticle extends StatefulWidget {
  const PostArticle({super.key});

  @override
  State<PostArticle> createState() => _PostArticleState();
}

class _PostArticleState extends State<PostArticle> {
  String feelingState = "";
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tạo bài viết",
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Đăng',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Image(
                image: AssetImage('assets/images/icons/avatar_icon.png'),
                width: 60,
                height: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Hóa Oppa ${feelingState != "" ? "-- cảm thấy ${feelingState}" : ""}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                  Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.language_rounded,
                              color: Colors.black54,
                              size: 18,
                            ),
                            Text(
                              "Công khai",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            )
                          ],
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextField(
                maxLines: 10,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Bạn đang nghĩ gì ?",
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    )),
              ),
            ),
            _selectedImage != null
                ? Image.file(_selectedImage!) // Hiển thị ảnh đã chọn
                : Container(), // Khoảng trắng nếu không có ảnh
            Padding(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((context) => Container(
                            height: 200,
                            color: Colors.white,
                            child: Center(
                                child: ListView(
                              padding: const EdgeInsets.all(8),
                              children: <Widget>[
                                Container(
                                  height: 80,
                                  color: Colors.green[500],
                                  child: Center(
                                      child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 40,
                                    child: ElevatedButton(
                                      child: const Text("Chọn ảnh từ máy"),
                                      onPressed: () {
                                        _pickImageFromGallery();
                                      },
                                    ),
                                  )),
                                ),
                                Container(
                                    height: 80,
                                    color: Colors.green[100],
                                    child: Center(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            height: 40,
                                            child: ElevatedButton(
                                              child: Text("Chụp ảnh"),
                                              onPressed: () {
                                                _pickImageFromCamera();
                                              },
                                            )))),
                              ],
                            )))));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: BorderDirectional(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.green,
                          size: 28,
                        ),
                        Text("Ảnh/Video")
                      ],
                    ),
                  ),
                )),

            Padding(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  onTap: () {
                    _awaitReturnValueFromPickerFeelings(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: BorderDirectional(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.emoji_emotions_outlined,
                          color: Colors.yellow,
                          size: 28,
                        ),
                        Text("Cảm xúc/Hoạt động")
                      ],
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: BorderDirectional(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.blue,
                        size: 28,
                      ),
                      Text("Gắn thẻ bạn bè")
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: BorderDirectional(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.photo_camera,
                        color: Colors.lightBlueAccent,
                        size: 28,
                      ),
                      Text("Máy ảnh")
                    ],
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: BorderDirectional(
                          top: BorderSide(color: Colors.grey, width: 0.5))),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.gif_box_rounded,
                        color: Colors.pinkAccent,
                        size: 28,
                      ),
                      Text("GIF")
                    ],
                  ),
                )),
          ],
        )
      ]),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  void _awaitReturnValueFromPickerFeelings(BuildContext context) async {
    // start PickerFeelings screen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PickerFeelings(),
        ));

    // after the feelingState comes back update the Text widget with it
    setState(() {
      feelingState = result;
    });
  }
}
