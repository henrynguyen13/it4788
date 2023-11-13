import 'package:flutter/material.dart';
import 'package:it4788/personal_page/personal_page.dart';

class AllFriendPage extends StatefulWidget {
  const AllFriendPage({super.key});

  @override
  State<AllFriendPage> createState() => _AllFriendPageState();
}

class _AllFriendPageState extends State<AllFriendPage> {
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'A',
    'A',
    'A'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Cat Nguyen')),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 60,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(115, 173, 169, 169),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Colors.black45,
                          size: 32.0,
                        ),
                        SizedBox(
                          width: 350,
                          height: 45,
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Tìm kiếm bạn bè',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                    textAlign: TextAlign.left,
                    '365 người bạn',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    )),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                    child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(60), // Image border
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(
                                        56), // Image radius
                                    child: Image.network(
                                        'https://pbs.twimg.com/media/FsPqq36agAABXJB.jpg',
                                        fit: BoxFit.cover),
                                  ),
                                )),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Text(
                                        textAlign: TextAlign.left,
                                        'Mẻo meo',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                      child: Text(
                                        textAlign: TextAlign.left,
                                        '123 người bạn chung',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () => {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return SizedBox(
                                      height: 600,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () => {},
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.black45,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Xem bạn bè của Meo',
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
                                                onTap: () => {},
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.message,
                                                      color: Colors.black45,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Nhắn tin cho Meo',
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
                                                onTap: () => {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const PersonalPage()),
                                                  )
                                                },
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
                                                        'Xem trang cá nhân của Meo',
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
                                                onTap: () => {},
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.block_rounded,
                                                      color: Colors.black45,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Chặn Meo',
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
                                                onTap: () => {},
                                                child: const Row(
                                                  children: [
                                                    Icon(
                                                      Icons.person_remove,
                                                      color: Colors.red,
                                                      size: 24.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(20),
                                                      child: Text(
                                                        'Hủy kết bạn với Meo',
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
                            child: const Icon(
                              Icons.more_vert,
                              color: Colors.black45,
                              size: 24.0,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ));
  }
}
