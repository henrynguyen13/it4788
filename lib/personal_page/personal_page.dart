import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/personal_page/all_friend_page.dart';
import 'package:it4788/personal_page/edit_personal_page.dart';
import 'package:it4788/post_article/post_article.dart';
import 'package:it4788/service/friend_service.dart';
import 'package:it4788/service/setting_service.dart';
import 'package:it4788/widgets/post_widget.dart';
import 'package:it4788/personal_page/preview_avatar.dart';
import 'package:it4788/personal_page/preview_coverage_image.dart';
import 'package:it4788/personal_page/setting_personal_page.dart';
import 'package:it4788/service/profile_sevice.dart';
import 'package:image_picker/image_picker.dart';

import '../service/authStorage.dart';

class PersonalPage extends StatefulWidget {
  final String id;

  const PersonalPage({super.key, required this.id});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  late Future<List<dynamic>> _futures;
  late UserInfor userInfor;
  late UserFriends userFriends;
  ListPost? listPost;
  String? userId;
  String? curId;
  bool isRequest = false;
  int index = 0;
  int count = 10;
  bool isLoading = false;
  String? coins;

  @override
  void initState() {
    super.initState;
    getData();
    curId = widget.id;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreData();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        index += count;
      });
      var tmp = await ProfileSevice().getMyListPost(curId!, index, count);

      setState(() {
        listPost!.data.post.addAll(tmp!.data.post);
        isLoading = false;
      });
    }
  }

  Future<String?> _getUserId() async {
    return await Storage().getUserId();
  }

  void getData() async {
    var profileAPI = ProfileSevice();
    _futures = profileAPI.getDataForPersonalPage(widget.id, index, count);
    userId = await _getUserId();
  }

  void navigateToPreviewAvatar(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewAvatar(
          imagePath: imagePath,
          userInfor: userInfor,
        ),
      ),
    );
  }

  void navigateToPreviewCoverageImage(String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewCoverageImage(
          imagePath: imagePath,
          userInfor: userInfor,
        ),
      ),
    );
  }

  Future getAvatarImage() async {
    try {
      // Chọn ảnh từ gallery
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile == null) {
        // Người dùng không chọn ảnh
        return;
      }

      navigateToPreviewAvatar(pickedFile.path);
    } catch (e) {
      rethrow;
    }
  }

  Future getCoverImage() async {
    try {
      // Chọn ảnh từ gallery
      var pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 800,
        maxWidth: 800,
      );

      if (pickedFile == null) {
        // Người dùng không chọn ảnh
        return;
      }

      navigateToPreviewCoverageImage(pickedFile.path);
    } catch (e) {
      rethrow;
    }
  }

  bool isCurrentUser() {
    if (curId == userId) return true;
    return false;
  }

  Future setRequestFriend(String id) async {
    try {
      await FriendService().setRequestFriend(id);
      setState(() {
        isRequest = true;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _codeController = TextEditingController();
    final TextEditingController _coinController = TextEditingController();

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
              userInfor = snapshot.data!.elementAt(0);
              userFriends = snapshot.data!.elementAt(1);
              listPost ??= snapshot.data!.elementAt(2);
              coins = userInfor.data.coins;
              return SingleChildScrollView(
                  controller: _scrollController,
                  physics: const ScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
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
                                  isCurrentUser()
                                      ? showModalBottomSheet(
                                          context: context,
                                          builder: (builder) {
                                            return SizedBox(
                                              height: 200,
                                              width: double.infinity,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            getCoverImage(),
                                                        child: const Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .picture_in_picture_outlined,
                                                              color: Colors
                                                                  .black45,
                                                              size: 24.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              child: Text(
                                                                'Xem ảnh bìa',
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
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: GestureDetector(
                                                        onTap: () =>
                                                            getCoverImage(),
                                                        child: const Row(
                                                          children: [
                                                            Icon(
                                                              Icons.upload,
                                                              color: Colors
                                                                  .black45,
                                                              size: 24.0,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              child: Text(
                                                                'Tải ảnh lên',
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
                                      : {}
                                },
                                child: Container(
                                    child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(20), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        56), // Image radius
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
                                          isCurrentUser()
                                              ? showModalBottomSheet(
                                                  context: context,
                                                  builder: (builder) {
                                                    return SizedBox(
                                                      height: 100,
                                                      width: double.infinity,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () =>
                                                                    getAvatarImage(),
                                                                child:
                                                                    const Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .photo_outlined,
                                                                      color: Colors
                                                                          .black45,
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              20),
                                                                      child:
                                                                          Text(
                                                                        'Chọn ảnh đại diện',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style:
                                                                            TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize:
                                                                              20,
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
                                              : {}
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
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: FaIcon(
                                FontAwesomeIcons.coins,
                                color: Color.fromARGB(255, 255, 189, 7),
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text('Coins: $coins',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red[600]!)),
                                onPressed: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Mua coins'),
                                        content: SingleChildScrollView(
                                          child: Form(
                                              key: _formKey,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(
                                                        'Mã code',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                          vertical: 12,
                                                        ),
                                                        child: SizedBox(
                                                          child: TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              // contentPadding: EdgeInsets.zero,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                borderSide: const BorderSide(
                                                                    width: 2,
                                                                    color: Color(
                                                                        0xFF1878F2)),
                                                              ),
                                                              hintText:
                                                                  'Nhập mã code...',
                                                            ),
                                                            onChanged:
                                                                (value) => {},
                                                            controller:
                                                                _codeController,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Đây là trường bắt buộc';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5),
                                                      child: Text(
                                                        'Số coin cần mua',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 5),
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                          vertical: 12,
                                                        ),
                                                        child: SizedBox(
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
                                                                borderSide: const BorderSide(
                                                                    width: 2,
                                                                    color: Color(
                                                                        0xFF1878F2)),
                                                              ),
                                                              hintText:
                                                                  'Nhập số coin cần mua...',
                                                            ),
                                                            onChanged:
                                                                (value) => {
                                                              setState(() {})
                                                            },
                                                            controller:
                                                                _coinController,
                                                            validator: (value) {
                                                              if (value ==
                                                                      null ||
                                                                  value
                                                                      .isEmpty) {
                                                                return 'Đây là trường bắt buộc';
                                                              } else {
                                                                double?
                                                                    parsedValue =
                                                                    double.tryParse(
                                                                        value);

                                                                if (parsedValue ==
                                                                    null) {
                                                                  return 'Vui lòng nhập đúng định dạng số';
                                                                }

                                                                if (parsedValue %
                                                                        1 !=
                                                                    0) {
                                                                  return 'Vui lòng nhập số nguyên';
                                                                }
                                                                if (parsedValue <=
                                                                    0) {
                                                                  return 'Giá trị phải lớn hơn 0';
                                                                }
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ])),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, 'Hủy'),
                                            child: const Text('Hủy',
                                                style: TextStyle(fontSize: 18)),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                String code =
                                                    _codeController.text;
                                                String coins =
                                                    _coinController.text;

                                                final response =
                                                    await SettingService()
                                                        .buyCoins(code, coins);

                                                final jsonResponse =
                                                    json.decode(response.data);

                                                String message =
                                                    jsonResponse['message'];

                                                if (message == 'OK') {
                                                  Navigator.pop(context, 'Mua');
                                                  getData();
                                                  setState(() {
                                                    coins =
                                                        userInfor.data.coins;
                                                  });
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                      'Mua coins thành công',
                                                    ),
                                                  ));
                                                }
                                              }
                                            },
                                            child: const Text(
                                              'Mua',
                                              style: TextStyle(
                                                  color: Color(0xFF1878F2),
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                child: const Row(
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.plus,
                                      color: Color.fromARGB(234, 255, 255, 255),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.cartShopping,
                                      color: Color.fromARGB(234, 255, 255, 255),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          !isCurrentUser()
                              ? TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 65, 50, 233)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 57, 47, 232)),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.focused) ||
                                            states.contains(
                                                MaterialState.pressed)) {
                                          return Colors.blue.withOpacity(0.12);
                                        }
                                        return null; // Defer to the widget's default.
                                      },
                                    ),
                                  ),
                                  onPressed: () {
                                    if (userInfor.data.isFriend == "0") {
                                      setRequestFriend(userInfor.data.id);
                                    }
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(90, 5, 90, 5),
                                    child: Text(
                                      userInfor.data.isFriend == "1"
                                          ? 'Bạn bè'
                                          : !isRequest
                                              ? 'Thêm bạn bè'
                                              : 'Đã gửi lời mời',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white),
                                    ),
                                  ))
                              : Container(),
                          isCurrentUser()
                              ? TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xFF1878F2)),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.focused) ||
                                            states.contains(
                                                MaterialState.pressed)) {
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
                                              SettingPersonalPage(
                                                userInfor: userInfor,
                                              )),
                                    );
                                  },
                                  child: const Text(
                                    '...',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ))
                              : Container(),
                        ],
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
                                            text: userInfor
                                                    .data.address.isNotEmpty
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
                                            text: userInfor
                                                    .data.country.isNotEmpty
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
                      isCurrentUser()
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              width: double.infinity,
                              child: TextButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(
                                                255, 187, 226, 245)),
                                    overlayColor: MaterialStateProperty
                                        .resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                        if (states.contains(
                                                MaterialState.focused) ||
                                            states.contains(
                                                MaterialState.pressed)) {
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
                                              EditPersonalPage(
                                                userInfor: userInfor,
                                              )),
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
                            )
                          : Container(),
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
                                      onTap: () => {},
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
                          height: userFriends.data.friends.isNotEmpty
                              ? userFriends.data.friends.length > 3
                                  ? 300
                                  : 150
                              : 0,
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
                                          size: const Size.fromRadius(54),
                                          child: Image.network(
                                            item.avatar.isNotEmpty
                                                ? item.avatar
                                                : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(item.username,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                        maxLines:
                                            2, // Số dòng tối đa bạn muốn hiển thị
                                        overflow: TextOverflow.ellipsis),
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
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
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
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AllFriendPage(id: curId!)),
                              );
                            },
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
                      isCurrentUser()
                          ? Container(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
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
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: NetworkImage(
                                                  userInfor.data.avatar
                                                          .isNotEmpty
                                                      ? userInfor.data.avatar
                                                      : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 300,
                                            height: 60,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelText:
                                                    'Enter your username',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: double.infinity,
                                      height: 2,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 183, 180, 180)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: double.infinity,
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: double.infinity,
                                      height: 15,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 144, 142, 142)),
                                      ),
                                    ),
                                  ]),
                            )
                          : Container(),
                      Container(
                          child: ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == listPost!.data.post.length) {
                                  return const SizedBox(
                                      height: 300,
                                      width: double.infinity,
                                      child: Center(
                                          child: CircularProgressIndicator()));
                                } else {
                                  return PostWidget(
                                      post: listPost!.data.post[index]);
                                }
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(),
                              itemCount: listPost!.data.post.length +
                                  (isLoading ? 1 : 0))),
                    ],
                  ));
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Text('No data available');
            }
          }),
    );
  }
}
