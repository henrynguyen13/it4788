import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/model/user_model.dart';
import 'package:it4788/personal_page/all_friend_page.dart';
import 'package:it4788/personal_page/edit_personal_page.dart';
import 'package:it4788/personal_page/setting_personal_page.dart';
import 'package:it4788/service/profileAPI.dart';
import 'package:image_picker/image_picker.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  late Future<List<dynamic>> _futures;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    getData();
  }

  void getData() async {
    var profileAPI = ProfileAPI();
    _futures = profileAPI.getDataForPersonalPage('193');
  }

  Future getImage() async {
    try {
      // Chọn ảnh từ gallery
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500,
        maxWidth: 500,
      );

      if (pickedFile == null) {
        // Người dùng không chọn ảnh
        return;
      }

      File imageFile = File(pickedFile.path);

      ProfileAPI().setUserInfor("username", "desciption", imageFile, "address",
          "city", "country", imageFile, "link");
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang cá nhân'),
      ),
      body: FutureBuilder<List<dynamic>>(
          future: _futures,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              UserInfor userInfor = snapshot.data!.elementAt(0);
              UserFriends userFriends = snapshot.data!.elementAt(1);

              return SingleChildScrollView(
                  child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 400,
                      ),
                      Container(
                          padding: const EdgeInsets.all(5.0),
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: GestureDetector(
                            onTap: () => {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return SizedBox(
                                      height: 200,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () => getImage(),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .picture_in_picture_outlined,
                                                      color: Colors.black45,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Xem ảnh bìa',
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () => getImage(),
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.upload,
                                                      color: Colors.black45,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Tải ảnh lên',
                                                        textAlign:
                                                            TextAlign.center,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                        ],
                                      ),
                                    );
                                  })
                            },
                            child: Container(
                                child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(56), // Image radius
                                child: Image.network(
                                    userInfor.data.coverImage.isNotEmpty
                                        ? userInfor.data.coverImage
                                        : 'https://wallpapers.com/images/hd/light-grey-background-cxk0x5hxxykvb55z.jpg',
                                    fit: BoxFit.cover),
                              ),
                            )),
                          )),
                      Positioned(
                          top: 200,
                          left: 100,
                          child: Center(
                            child: GestureDetector(
                                onTap: () => {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (builder) {
                                            return SizedBox(
                                              height: 100,
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () => getImage(),
                                                        child: const Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .photo_outlined,
                                                              color: Colors
                                                                  .black45,
                                                              size: 24.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              child: Text(
                                                                'Chọn ảnh đại diện',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            );
                                          })
                                    },
                                child: CircleAvatar(
                                  radius: 100,
                                  backgroundImage: NetworkImage(userInfor
                                          .data.avatar.isNotEmpty
                                      ? userInfor.data.avatar
                                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
                                )),
                          )),
                    ],
                  ),
                  Text(
                    userInfor.data.username.isNotEmpty
                        ? userInfor.data.username
                        : "unknow",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 187, 226, 245)),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed)) {
                              return Colors.blue.withOpacity(0.12);
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SettingPersonalPage()),
                        );
                      },
                      child: const Text(
                        '...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 3,
                        child: Container(
                          color: const Color.fromARGB(
                              139, 140, 141, 142), // Màu nền của SizedBox
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.work,
                              color: Colors.black45,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text(
                                userInfor.data.city.isNotEmpty
                                    ? userInfor.data.city
                                    : 'unknown',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.home,
                              color: Colors.black45,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Sống tại ',
                                  style: const TextStyle(fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: userInfor.data.address.isNotEmpty
                                            ? userInfor.data.address
                                            : 'unknow',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_pin,
                              color: Colors.black45,
                              size: 24.0,
                              semanticLabel:
                                  'Text to announce in accessibility modes',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text.rich(
                                TextSpan(
                                  text: 'Đến từ ',
                                  style: const TextStyle(fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: userInfor.data.country.isNotEmpty
                                            ? userInfor.data.country
                                            : "unknow",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 187, 226, 245)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EditPersonalPage()),
                          );
                        },
                        child: const Text(
                          'Chỉnh sửa chi tiết công khai',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 3,
                        child: Container(
                          color: const Color.fromARGB(
                              139, 140, 141, 142), // Màu nền của SizedBox
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Bạn bè',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () => {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllFriendPage()),
                                    )
                                  },
                                  child: const Text(
                                    'Tìm bạn bè',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        color: Colors.blue),
                                  ),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                textAlign: TextAlign.left,
                                "${userFriends.data.total.toString()} người bạn",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: SizedBox(
                      height: userFriends.data.friends.isNotEmpty ? 300 : 0,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0, // Khoảng cách giữa các cột
                          mainAxisSpacing: 8.0, // Khoảng cách giữa các hàng
                        ),
                        itemCount: userFriends.data.friends.length,
                        itemBuilder: (context, index) {
                          var item = userFriends.data.friends[index];

                          return SizedBox(
                            child: Column(
                              children: [
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: SizedBox.fromSize(
                                      size: const Size.fromRadius(56),
                                      child: Image.network(
                                        item.avatar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  item.username,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 208, 211, 213)),
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.focused) ||
                                  states.contains(MaterialState.pressed)) {
                                return Colors.blue.withOpacity(0.12);
                              }
                              return null; // Defer to the widget's default.
                            },
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Xem tất cả bạn bè',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 15,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 144, 142, 142)),
                    ),
                  ),
                  Container(
                    child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Bài viết',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        'https://aiartshop.com/cdn/shop/files/laughing-fat-cat-animal-ai-art-143.webp?v=1686132290'),
                                  ),
                                ),
                                SizedBox(
                                  width: 300,
                                  height: 60,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Enter your username',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 2,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 183, 180, 180)),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 30,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 15,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 144, 142, 142)),
                            ),
                          ),
                        ]),
                  )
                ],
              ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('No data available');
            }
          }),
    );
  }
}
