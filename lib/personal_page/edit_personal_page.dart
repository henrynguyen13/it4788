import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/personal_page/preview_avatar.dart';
import 'package:it4788/personal_page/preview_coverage_image.dart';
import 'package:it4788/service/profile_sevice.dart';

class EditPersonalPage extends StatefulWidget {
  final UserInfor userInfor;

  const EditPersonalPage({super.key, required this.userInfor});

  @override
  State<EditPersonalPage> createState() => _EditPersonalPageState();
}

class _EditPersonalPageState extends State<EditPersonalPage> {
  late UserInfor userInfor;
  late TextEditingController _descriptionController;
  late TextEditingController _cityController;
  late TextEditingController _addressController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    userInfor = widget.userInfor;
    _descriptionController = TextEditingController();
    _cityController = TextEditingController();
    _addressController = TextEditingController();
    _countryController = TextEditingController();

    _descriptionController.value = _descriptionController.value.copyWith(
      text: userInfor.data.description,
      selection:
          TextSelection.collapsed(offset: userInfor.data.description.length),
    );

    _cityController.value = _descriptionController.value.copyWith(
      text: userInfor.data.city,
      selection:
          TextSelection.collapsed(offset: userInfor.data.description.length),
    );

    _addressController.value = _descriptionController.value.copyWith(
      text: userInfor.data.address,
      selection:
          TextSelection.collapsed(offset: userInfor.data.description.length),
    );

    _countryController.value = _descriptionController.value.copyWith(
      text: userInfor.data.country,
      selection:
          TextSelection.collapsed(offset: userInfor.data.description.length),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
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

  Future saveUserInfor() async {
    try {
      await ProfileSevice().setUserInfor(
          widget.userInfor.data.username,
          widget.userInfor.data.description,
          null,
          widget.userInfor.data.address,
          widget.userInfor.data.city,
          widget.userInfor.data.country,
          null,
          widget.userInfor.data.link);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chỉnh sửa trang cá nhân'),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ảnh đại diện',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: GestureDetector(
                            onTap: () {
                              getAvatarImage();
                            },
                            child: const Text(
                              'Chỉnh sửa',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color(0xFF1878F2)),
                            ),
                          )),
                    ],
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(5.0),
                height: 300,
                child: GestureDetector(
                  onTap: () => {getAvatarImage()},
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(userInfor
                            .data.avatar.isNotEmpty
                        ? userInfor.data.avatar
                        : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png'),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ảnh bìa',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            getCoverImage();
                          },
                          child: const Text(
                            'Chỉnh sửa',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1878F2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(5.0),
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: GestureDetector(
                  onTap: () => {getCoverImage()},
                  child: Container(
                      child: ClipRRect(
                    borderRadius: BorderRadius.circular(20), // Image border
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tiểu sử',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              userInfor.data.description =
                                  _descriptionController.text;
                            });
                            saveUserInfor();
                          },
                          child: const Text(
                            'Lưu',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1878F2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tiểu sử',
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Chi tiết',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              userInfor.data.address = _addressController.text;
                              userInfor.data.city = _cityController.text;
                              userInfor.data.country = _countryController.text;
                            });
                            saveUserInfor();
                          },
                          child: const Text(
                            'Chỉnh sửa',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1878F2)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.work,
                          color: Colors.black45,
                          size: 24.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _cityController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Làm việc tại',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.black45,
                          size: 24.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Sống tại',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.black45,
                          size: 24.0,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _countryController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Đến từ',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
