import 'package:flutter/material.dart';
import 'package:it4788/personal_page/all_friend_page.dart';
import 'package:it4788/personal_page/edit_personal_page.dart';
import 'package:it4788/personal_page/setting_personal_page.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({super.key});

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang cá nhân'),
      ),
      body: SingleChildScrollView(
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () => {},
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.picture_in_picture_outlined,
                                              color: Colors.black45,
                                              size: 24.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Text(
                                                'Xem ảnh bìa',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () => {},
                                        child: const Row(
                                          children: [
                                            Icon(
                                              Icons.upload,
                                              color: Colors.black45,
                                              size: 24.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Text(
                                                'Tải ảnh lên',
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
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
                      borderRadius: BorderRadius.circular(20), // Image border
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(56), // Image radius
                        child: Image.network(
                            'https://pbs.twimg.com/media/FsPqq36agAABXJB.jpg',
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
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () => {},
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.photo_outlined,
                                                color: Colors.black45,
                                                size: 24.0,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(20),
                                                child: Text(
                                                  'Chọn ảnh đại diện',
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
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
                      child: const CircleAvatar(
                        radius: 100,
                        backgroundImage: NetworkImage(
                            'https://aiartshop.com/cdn/shop/files/laughing-fat-cat-animal-ai-art-143.webp?v=1686132290'),
                      ),
                    ),
                  )),
            ],
          ),
          const Text(
            'Cat Nguyen',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
                      builder: (context) => const SettingPersonalPage()),
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
            child: const Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.work,
                      color: Colors.black45,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Hà Nội',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.black45,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text.rich(
                        TextSpan(
                          text: 'Sống tại',
                          style: TextStyle(fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Hà Nội',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_pin,
                      color: Colors.black45,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text.rich(
                        TextSpan(
                          text: 'Đến từ',
                          style: TextStyle(fontSize: 18),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Thủ Đô Ánh Sáng',
                                style: TextStyle(fontWeight: FontWeight.bold)),
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
                                  builder: (context) => const AllFriendPage()),
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
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        textAlign: TextAlign.left,
                        '10000000 người bạn',
                        style: TextStyle(
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
                height: 300,
                child: Expanded(
                  child: GridView.count(
                    // Create a grid with 3 columns. If you change the scrollDirection to
                    // horizontal, this produces 2 rows.
                    crossAxisCount: 3,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(6, (index) {
                      return SizedBox(
                        child: Column(
                          children: [
                            Container(
                                child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(56), // Image radius
                                child: Image.network(
                                    'https://pbs.twimg.com/media/FsPqq36agAABXJB.jpg',
                                    fit: BoxFit.cover),
                              ),
                            )),
                            const Text(
                              textAlign: TextAlign.left,
                              'Mẻo meo',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )),
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
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 144, 142, 142)),
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
      )),
    );
  }
}
