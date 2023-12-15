import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/home/home_screen.dart';
import 'package:it4788/service/auth.dart';

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
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 30.0),
              Container(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image border
                child: SizedBox(
                  width: double.infinity,
                  height: 400, // Image radius
                  child: avatar != null
                      ? Image.file(
                          avatar!,
                          width: 400,
                          height: 400,
                          fit: BoxFit.cover,
                        )
                      : const SizedBox(
                          height: 40,
                        ),
                ),
              )),
              const SizedBox(height: 15.0),
              ElevatedButton(
                  onPressed: () async {
                    await _pickImageFromGallery();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 147, 62, 181),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    "Chọn ảnh đại diện",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
                  )),
              const SizedBox(height: 30.0),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal:
                              24.0), // Điều chỉnh giá trị padding tại đây
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () async {
                  try {
                    final setUsernameResponse = await setUsername(username);
                    final jsonResponse = json.decode(setUsernameResponse.data);
                    print(jsonResponse);

                    String message = jsonResponse['message'];
                    print(message);

                    if (message == 'OK') {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Đăng nhập thành công !')));

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    }
                  } catch (e) {}
                },
                child: const Text('Xác nhận',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    // Chọn ảnh từ gallery
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) {
      // Người dùng không chọn ảnh đại diện
      return;
    }

    final imageTemporary = File(pickedImage.path);

    setState(() {
      avatar = imageTemporary;
    });
  }
}
