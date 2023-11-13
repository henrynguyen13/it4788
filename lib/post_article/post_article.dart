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
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/images/icons/avatar_icon.png'),
                width: 60,
                height: 60,
              ),
              Column(
                children: [
                  const Text("Hóa Oppa",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                        child: const Row(
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
            Padding(
                padding: const EdgeInsets.all(0),
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20))),
                        builder: (context) => Center(
                                child: Column(
                              children: [
                                ElevatedButton(
                                  child: const Text("Chọn ảnh từ máy"),
                                  onPressed: () {
                                    _pickImageFromGallery();
                                  },
                                ),
                                ElevatedButton(
                                  child: Text("Chụp ảnh"),
                                  onPressed: () {
                                    _pickImageFromCamera();
                                  },
                                )
                              ],
                            )));
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
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PickerFeelings()),
                    );
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
}
