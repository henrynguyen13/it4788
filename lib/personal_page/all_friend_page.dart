import 'package:flutter/material.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/personal_page/personal_page.dart';
import 'package:it4788/service/profile_sevice.dart';

class AllFriendPage extends StatefulWidget {
  const AllFriendPage({super.key});

  @override
  State<AllFriendPage> createState() => _AllFriendPageState();
}

class _AllFriendPageState extends State<AllFriendPage> {
  late List<Friend> userFriendList;
  late Future<UserFriends?> _userFriendFuture;
  late String total;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _userFriendFuture = ProfileSevice().getUserFriend('193', 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Danh sách bạn bè')),
        body: FutureBuilder(
          future: _userFriendFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              userFriendList = snapshot.data!.data.friends;
              total = snapshot.data!.data.total;
              return SingleChildScrollView(
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
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          textAlign: TextAlign.left,
                          '$total người bạn',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          )),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: userFriendList.length,
                        itemBuilder: (BuildContext context, int index) {
                          Friend item = userFriendList[index];

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
                                        borderRadius: BorderRadius.circular(
                                            60), // Image border
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              56), // Image radius
                                          child: Image.network(
                                              item.avatar.isNotEmpty
                                                  ? item.avatar
                                                  : 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Default_pfp.svg/2048px-Default_pfp.svg.png',
                                              fit: BoxFit.cover),
                                        ),
                                      )),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 0, 0),
                                            child: Text(
                                              textAlign: TextAlign.left,
                                              item.username,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 0, 0, 0),
                                            child: Text(
                                              textAlign: TextAlign.left,
                                              item.sameFriends,
                                              style: const TextStyle(
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
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () => {},
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.person,
                                                            color:
                                                                Colors.black45,
                                                            size: 24.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Text(
                                                              'Xem bạn bè của ${item.username}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
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
                                                      onTap: () => {},
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.message,
                                                            color:
                                                                Colors.black45,
                                                            size: 24.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Text(
                                                              'Nhắn tin cho ${item.username}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
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
                                                      onTap: () => {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const PersonalPage()),
                                                        )
                                                      },
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .picture_in_picture_outlined,
                                                            color:
                                                                Colors.black45,
                                                            size: 24.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Text(
                                                              'Xem trang cá nhân của ${item.username}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
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
                                                      onTap: () => {},
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.block_rounded,
                                                            color:
                                                                Colors.black45,
                                                            size: 24.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Text(
                                                              'Chặn ${item.username}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
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
                                                      onTap: () => {},
                                                      child: Row(
                                                        children: [
                                                          const Icon(
                                                            Icons.person_remove,
                                                            color: Colors.red,
                                                            size: 24.0,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            child: Text(
                                                              'Hủy kết bạn với ${item.username}',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style:
                                                                  const TextStyle(
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
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('No data available');
            }
          },
        ));
  }
}
