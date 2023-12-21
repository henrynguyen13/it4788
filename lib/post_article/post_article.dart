import 'dart:convert';
import 'dart:convert' show json;
import 'dart:io';
import 'dart:io' show File;
import 'package:it4788/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/post_article/feelings_activities/feelings_activities_picker.dart';
import 'package:it4788/post_article/image_detail_add_screen.dart';
import 'package:it4788/post_article/image_detail_screen.dart';
import 'package:it4788/post_article/post_draft.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/post_sevice.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:video_player/video_player.dart';

class PostArticle extends StatefulWidget {
  const PostArticle({super.key});

  @override
  State<PostArticle> createState() => _PostArticleState();
}

class _PostArticleState extends State<PostArticle> {
  String feelingState = "";
  String? username = "";
  String? avatar;

  List<XFile?> selectedImages = [];
  XFile? video;
  String postContent = "";
  String status = "Hyped";
  String auto_accept = "1";

  String exportFilePath = "D:/20231/DNT/it4788/assets/post_draft.json";
  List<PostDraft> drafts = [];

  bool isKeyboardVisible = false;

  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _getUsername().then((value) {
      setState(() {
        username = value ?? "";
      });
    });

    _getAvatar().then((value) {
      setState(() {
        avatar = value ?? "";
      });
    });

    // KeyboardVisibilityController().onChange.listen((bool visible) {
    //   setState(() {
    //     isKeyboardVisible = visible;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              MaterialButton(
                  minWidth: 10,
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 3,
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  child: Text(
                                      "Bạn muốn hoàn thành bài viết của mình sau ?"),
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  child: Text(
                                    "Lưu làm bản nháp hoặc bạn có thể tiếp tục chỉnh sửa",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextButton(
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(Icons.save_alt_rounded),
                                      ),
                                      Text('Lưu làm bản nháp'),
                                    ],
                                  ),
                                  onPressed: () {
                                    PostDraft newPostDraft = PostDraft(
                                      // selectedImages
                                      //     .map((image) => image?.path ?? "")
                                      //     .toList(),
                                      postContent,
                                      // status,
                                      // auto_accept);
                                      // drafts.add(newPostDraft);
                                    );
                                    writePostContent(postContent);
                                    setState(() {
                                      selectedImages = [];
                                      postContent = "";
                                      status = 'Hyped';
                                      auto_accept = '1';
                                    });

                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                    child: const Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Icon(Icons.delete),
                                        ),
                                        Text('Bỏ bài viết'),
                                      ],
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen(),
                                          ));
                                    }),
                                TextButton(
                                  child: const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Icon(Icons.check),
                                      ),
                                      Text('Tiếp tục chỉnh sửa'),
                                    ],
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.arrow_back)),
              const Text(
                "Tạo bài viết",
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          actions: [
            MaterialButton(
              onPressed: () async {
                try {
                  final addPostResponse = await PostSevice().addPost(
                      selectedImages, video, postContent, status, auto_accept);

                  final jsonResponse = json.decode(addPostResponse.data);

                  String message = jsonResponse['message'];

                  if (message == 'OK') {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Đăng bài viết thành công !')));

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }
                } catch (e) {
                  print(e);
                }
              },
              child: const Text(
                'Đăng',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: ClipOval(
                          child: avatar != ""
                              ? Image.network(
                                  avatar!,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                )
                              : const Image(
                                  image: AssetImage(
                                      'assets/images/icons/avatar_icon.png'),
                                  width: 60,
                                  height: 60,
                                ),
                        )),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${username} ${feelingState != "" ? "-- cảm thấy ${feelingState}" : ""}",
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
              SingleChildScrollView(
                child: Flexible(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(children: [
                        TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Bạn đang nghĩ gì ?",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              )),
                          onChanged: (text) {
                            setState(() {
                              postContent = text;
                            });
                          },
                        ),
                      ])),
                ),
              ),
              // if (!isKeyboardVisible)
              Column(
                children: [
                  // video == null && selectedImages.isEmpty
                  Container(
                    child: selectedImages.isNotEmpty
                        ? _buildImageSection(selectedImages)
                        : Padding(
                            padding: const EdgeInsets.all(0),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 3,
                            )),
                  ),
                  // : Container(
                  //     child: video != null && selectedImages.isEmpty
                  //         ? _buildVideoSection(video)
                  //         : Padding(
                  //             padding: const EdgeInsets.all(0),
                  //             child: SizedBox(
                  //               height:
                  //                   MediaQuery.of(context).size.height /
                  //                       3,
                  //             )),
                  //   ),
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
                                        color: const Color(0xFF1878F2),
                                        child: Center(
                                            child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 40,
                                          child: ElevatedButton(
                                            child:
                                                const Text("Chọn ảnh từ máy"),
                                            onPressed: () {
                                              _pickImagesFromGallery();
                                              Navigator.pop(context);
                                            },
                                          ),
                                        )),
                                      ),
                                      Container(
                                          height: 80,
                                          color: Color.fromARGB(
                                              255, 153, 189, 237),
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
                                                      Navigator.pop(context);
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
                              Text("Ảnh")
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
                                            child:
                                                const Text("Chọn video từ máy"),
                                            onPressed: () {
                                              _pickVideoFromGallery();
                                              Navigator.pop(context);
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
                                                    child: Text("Quay video"),
                                                    onPressed: () {
                                                      _pickVideoFromCamera();
                                                      Navigator.pop(context);
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
                                Icons.photo_camera,
                                color: Colors.blue,
                                size: 28,
                              ),
                              Text("Video")
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
                              Icons.gif_box_rounded,
                              color: Colors.pinkAccent,
                              size: 28,
                            ),
                            Text("GIF")
                          ],
                        ),
                      )),
                ],
              ),
              // if (isKeyboardVisible)
              //   video == null && selectedImages.isEmpty
              //       ? Container(
              //           child: selectedImages.isNotEmpty
              //               ? _buildImageSection(selectedImages)
              //               : Padding(
              //                   padding: const EdgeInsets.all(0),
              //                   child: SizedBox(
              //                     height:
              //                         MediaQuery.of(context).size.height / 3,
              //                   )),
              //         )
              //       : Container(
              //           child: video != null && selectedImages.isEmpty
              //               ? _buildVideoSection(video)
              //               : Padding(
              //                   padding: const EdgeInsets.all(0),
              //                   child: SizedBox(
              //                     height:
              //                         MediaQuery.of(context).size.height / 3,
              //                   )),
              //         ),
              // const Row(
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              //       child: Icon(
              //         Icons.image,
              //         color: Colors.green,
              //         size: 28,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              //       child: Icon(
              //         Icons.emoji_emotions_outlined,
              //         color: Colors.yellow,
              //         size: 28,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              //       child: Icon(
              //         Icons.person,
              //         color: Colors.blue,
              //         size: 28,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              //       child: Icon(
              //         Icons.photo_camera,
              //         color: Colors.lightBlueAccent,
              //         size: 28,
              //       ),
              //     ),
              //     Padding(
              //       padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              //       child: Icon(
              //         Icons.gif_box_rounded,
              //         color: Colors.pinkAccent,
              //         size: 28,
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ));
  }

  Future _pickImagesFromGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage(imageQuality: 100);

    if (pickedImages.isEmpty) return;

    setState(() {
      if (pickedImages.length <= 4) {
        selectedImages.addAll(pickedImages);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bạn chỉ được chọn tối đa 4 ảnh !')));
        return;
      }
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      selectedImages.add(returnedImage);
    });
  }

  Future _pickVideoFromGallery() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo == null) return;

    video = pickedVideo;
    print(video);

    _videoPlayerController = VideoPlayerController.file(File(video!.path))
      ..initialize().then((_) => {setState(() => {})});

    _videoPlayerController.play();
  }

  Future _pickVideoFromCamera() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.camera);

    if (pickedVideo == null) return;
  }

  void _awaitReturnValueFromPickerFeelings(BuildContext context) async {
    // start PickerFeelings screen and wait for it to finish with a result
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PickerFeelings(),
        ));

    // after the feelingState comes back update the Text widget with it
    setState(() {
      feelingState = result;
    });
  }

  // Widget _buildVideoSection(XFile? video) {
  //   if (video != null) {
  //     return _videoPlayerController.value.isInitialized
  //         ? AspectRatio(
  //             aspectRatio: _videoPlayerController.value.aspectRatio,
  //             child: VideoPlayer(_videoPlayerController))
  //         : Container();
  //   } else {
  //     return const SizedBox();
  //   }
  // }

  Widget _buildImageSection(List<XFile?> images) {
    if (images.length == 1) {
      return Image.file(File(images[0]!.path),
          height: 400, width: double.infinity, fit: BoxFit.cover);
    } else if (images.length == 2) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailAddScreen(
                    // imageUrls: images.map((image) => image!.url).toList(),
                    images: images,
                    initialPage: index,
                    onImageRemoved: (removedIndex, id) {
                      setState(() {
                        images.removeAt(removedIndex);
                      });
                    },
                  ),
                ),
              )
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Image.file(File(images[index]!.path),
                  height: 400, width: double.infinity, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else if (images.length == 3) {
      return Row(
        children: [
          Expanded(
            child: Image.file(File(images[0]!.path),
                height: 400, fit: BoxFit.cover),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Image.file(File(images[1]!.path),
                      height: 198, width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 2),
                  child: Image.file(File(images[2]!.path),
                      height: 198, width: double.infinity, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (images.length >= 4) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1),
            child: Image.file(File(images[index]!.path),
                height: 200, width: double.infinity, fit: BoxFit.cover),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Future<String?> _getUsername() async {
    return await Storage().getUsername();
  }

  Future<String?> _getAvatar() async {
    return await Storage().getAvatar();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/draft.txt');
  }

  Future<File> writePostContent(String content) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(content);
  }
}
