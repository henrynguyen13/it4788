import 'package:flutter/material.dart';

class EditPersonalPage extends StatefulWidget {
  const EditPersonalPage({super.key});

  @override
  State<EditPersonalPage> createState() => _EditPersonalPageState();
}

class _EditPersonalPageState extends State<EditPersonalPage> {
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ảnh đại diện',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Chỉnh sửa',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )),
            Container(
                padding: const EdgeInsets.all(5.0),
                height: 300,
                child: GestureDetector(
                  onTap: () => {},
                  child: const CircleAvatar(
                    radius: 120,
                    backgroundImage: NetworkImage(
                        'https://aiartshop.com/cdn/shop/files/laughing-fat-cat-animal-ai-art-143.webp?v=1686132290'),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Ảnh bìa',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Chỉnh sửa',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.blue),
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
                  onTap: () => {},
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
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tiểu sử',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Thêm',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Tiểu sử',
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Chi tiết',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          'Chỉnh sửa',
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.work,
                        color: Colors.black45,
                        size: 24.0,
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
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
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}
