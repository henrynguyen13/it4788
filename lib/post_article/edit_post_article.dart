import 'dart:io';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/edit_post.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/post_article/feelings_activities/feelings_activities_picker.dart';
import 'package:it4788/post_article/image_detail_screen.dart';
import 'package:it4788/service/post_sevice.dart';
import 'package:it4788/model/post_response.dart';

class EditPostArticle extends StatefulWidget {
  final String id;
  const EditPostArticle({super.key, required this.id});
  @override
  State<EditPostArticle> createState() => _EditPostArticleState();
}

class _EditPostArticleState extends State<EditPostArticle> {
  final TextEditingController _descriptionController = TextEditingController();
  late Future<PostResponse> _futures;
  String feelingState = "";
  File? _selectedImage;
  String? username;
  PostResponse? post;

  void getData() async {
    _futures = PostSevice().getPostById(widget.id);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget _buildImageSection(List<PostImage> images) {
    if (images.length == 1) {
      return Image.network(images[0].url,
          height: 400, width: double.infinity, fit: BoxFit.cover);
    } else if (images.length == 2 || images.length == 4) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(
                    imageUrls: images.map((image) => image.url).toList(),
                    initialPage: index,
                    onImageRemoved: (removedIndex) {
                      setState(() {
                        images.removeAt(removedIndex);
                      });
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Image.network(images[index].url,
                  height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else if (images.length == 3) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Handle onTap for the first image
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetailScreen(
                      imageUrls: images.map((image) => image.url).toList(),
                      initialPage: 0,
                      onImageRemoved: (removedIndex) {
                        setState(() {
                          images.removeAt(removedIndex);
                        });
                      },
                    ),
                  ),
                );
              },
              child:
                  Image.network(images[0].url, height: 400, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: GestureDetector(
                    onTap: () {
                      // Handle onTap for the second image
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailScreen(
                            imageUrls:
                                images.map((image) => image.url).toList(),
                            initialPage: 1,
                            onImageRemoved: (removedIndex) {
                              setState(() {
                                images.removeAt(removedIndex);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Image.network(images[1].url,
                        height: 198, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 2),
                  child: GestureDetector(
                    onTap: () {
                      // Handle onTap for the third image
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailScreen(
                            imageUrls:
                                images.map((image) => image.url).toList(),
                            initialPage: 2,
                            onImageRemoved: (removedIndex) {
                              setState(() {
                                images.removeAt(removedIndex);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    child: Image.network(images[2].url,
                        height: 198, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sửa bài viết",
            style: TextStyle(fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final response = await PostSevice().editPost(EditPostDto(
                    id: post!.data.id, described: _descriptionController.text));
              },
              child: const Text(
                'Sửa',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        body: FutureBuilder<PostResponse>(
            future: _futures,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                post = snapshot.data;
                _descriptionController.text = post?.data.described ?? '';
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(post!
                                    .data.author.avatar.isNotEmpty
                                ? post!.data.author.avatar
                                : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${post?.data.author.name} ${feelingState != "" ? "-- cảm thấy ${feelingState}" : ""}",
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
                                            color: Colors.black54,
                                            fontSize: 12),
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          maxLines:
                              null, // or set it to a specific number, e.g., 5
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      post?.data.image.isNotEmpty ?? false
                          ? _buildImageSection(post!.data.image)
                          : const SizedBox.shrink(),
                      // _selectedImage != null
                      //     ? Image.file(_selectedImage!) // Hiển thị ảnh đã chọn
                      //     : Container(), // Khoảng trắng nếu không có ảnh
                      const SizedBox(height: 20),
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              height: 40,
                                              child: ElevatedButton(
                                                child: const Text(
                                                    "Chọn ảnh từ máy"),
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
                                                      width:
                                                          MediaQuery.of(context)
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
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
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
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
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
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
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
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
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
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
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
                ]);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('No data available');
              }
            }));
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
