import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/home/home_screen.dart';
import 'package:it4788/sign_up/birthday.dart';

class SetUsernamePage extends StatefulWidget {
  const SetUsernamePage({super.key});

  @override
  State<SetUsernamePage> createState() => _SetUsernamePageState();
}

class _SetUsernamePageState extends State<SetUsernamePage> {
  String username = '';
  File? avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tên người dùng')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Bạn tên gì?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        username = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Tên đăng nhập',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15.0),
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
                    child: SizedBox(
                      width: double.infinity,
                      height: 200, // Image radius

                      child: avatar != null
                          ? Image(image: FileImage(avatar!), fit: BoxFit.cover)
                          : SizedBox(),
                    ))),
            MaterialButton(
                onPressed: () {
                  _pickImageFromGallery();
                },
                child: const Text("Ảnh đại diện")),
            const SizedBox(height: 30.0),
            TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0), // Điều chỉnh giá trị padding tại đây
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
              child: const Text('Tiếp',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 800,
        maxWidth: 800);

    if (returnedImage == null) return;
    setState(() {
      avatar = File(returnedImage.path);
      print("BUGGGG ${avatar}");
    });
  }
}
