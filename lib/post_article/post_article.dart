import 'dart:convert';
import 'dart:io';
import 'package:it4788/home/home_screen.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/post_article/feelings_activities/feelings_activities_picker.dart';
import 'package:it4788/post_article/post_draft.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/post_sevice.dart';
import 'package:it4788/service/profile_sevice.dart';
import 'package:path_provider/path_provider.dart';

class PostArticle extends StatefulWidget {
  const PostArticle({super.key});

  @override
  State<PostArticle> createState() => _PostArticleState();
}

class _PostArticleState extends State<PostArticle> {
  late PostDraft postDraft;

  String feelingState = "";
  String? username = "";
  String? avatar;

  List<XFile?> selectedImages = [];
  File? video;
  String postContent = "";
  String status = "Hyped";
  String auto_accept = "1";

  @override
  void initState() {
    super.initState();
    _getUsername().then((value) {
      setState(() {
        username = value ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          padding: EdgeInsets.all(8.0),
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
                                      Text('Lưu bản nháp'),
                                    ],
                                  ),
                                  onPressed: () async {
                                    postDraft.status = 'Hyped';
                                    postDraft.autoAccept = '1';

                                    await _savePostDraft(postDraft);
                                    setState(() {
                                      selectedImages = [];
                                      video = null;
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
                                      // Navigator.popUntil(context,
                                      //     ModalRoute.withName("/home"));
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

                  print("BUGGGGGG $jsonResponse");

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
                    avatar != null
                        ? Image.network("$avatar")
                        : const Image(
                            image: AssetImage(
                                'assets/images/icons/avatar_icon.png'),
                            width: 60,
                            height: 60,
                          ),
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
                          autofocus: true,
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
                              postDraft.postContent = text;
                            });
                          },
                        ),
                      ])),
                ),
              ),
              Container(
                child: selectedImages.isNotEmpty
                    ? _buildImageSection(selectedImages)
                    : Padding(
                        padding: EdgeInsets.all(0),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 3,
                        )),
              ),
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
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height: 40,
                                      child: ElevatedButton(
                                        child: const Text("Chọn ảnh từ máy"),
                                        onPressed: () {
                                          _pickImagesFromGallery();
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
          ),
        ));
  }

  Future _pickImagesFromGallery() async {
    final pickedImages = await ImagePicker().pickMultiImage(imageQuality: 100);

    if (pickedImages.isEmpty) return;

    setState(() {
      if (pickedImages.length <= 4) {
        postDraft.selectedImages = pickedImages;

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
      postDraft.selectedImages.add(returnedImage);
    });
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Image.file(File(images[index]!.path),
                height: 400, width: double.infinity, fit: BoxFit.cover),
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

  Future<String?> _getUserId() async {
    return await Storage().getUserId();
  }

  Future<String?> _getUsername() async {
    return await Storage().getUsername();
  }

  Future<String?> _getAvatar() async {
    return await Storage().getAvatar();
  }

  Future<void> _savePostDraft(PostDraft draft) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/post_draft.json');
    await file.writeAsString(draft.toJson().toString());
  }

  Future<PostDraft> _loadPostDraft() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/post_draft.json');
      final jsonString = await file.readAsString();
      final jsonMap = Map<String, dynamic>.from(json.decode(jsonString));
      return PostDraft.fromJson(jsonMap);
    } catch (e) {
      return PostDraft(
        selectedImages: [],
        video: null,
        postContent: '',
        status: 'Hyped',
        autoAccept: '1',
      );
    }
  }
}
