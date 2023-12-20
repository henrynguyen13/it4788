import 'package:flutter/material.dart';
import 'package:it4788/model/user_friends.dart';
import 'package:it4788/personal_page/personal_page.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/block_service.dart';
import 'package:it4788/service/friend_service.dart';
import 'package:it4788/service/profile_sevice.dart';

class AllFriendPage extends StatefulWidget {
  final String id;
  const AllFriendPage({super.key, required this.id});

  @override
  State<AllFriendPage> createState() => _AllFriendPageState();
}

class _AllFriendPageState extends State<AllFriendPage> {
  List<Friend> userFriendList = <Friend>[];
  Future<UserFriends?>? _future;
  String? total;
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  int index = 0;
  int count = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreFriends();
      }
    });
  }

  void loadMoreFriends() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        index += count; // Increment the index to load the next set of data
      });
      _future = ProfileSevice().getUserFriend(widget.id, index, count);
    }
  }

  void getData() async {
    setState(() {
      _future = ProfileSevice().getUserFriend(widget.id, index, count);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Danh sách bạn bè')),
        body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              userFriendList.addAll(snapshot.data!.data.friends);
              total = snapshot.data!.data.total;
              isLoading = false;
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
                                            30), // Image border
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              30), // Image radius
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
                                            height: 350,
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
                                                                    .all(10),
                                                            child: Text(
                                                              'Hiển thị danh sách bạn bè của ${item.username}',
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
                                                                fontSize: 14,
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
                                                                    .all(10),
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
                                                                fontSize: 14,
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
                                                                  PersonalPage(
                                                                      id: item
                                                                          .id)),
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
                                                                    .all(10),
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
                                                                fontSize: 14,
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
                                                      onTap: () {
                                                        showDialog<String>(
                                                            context: context,
                                                            builder: (BuildContext
                                                                    context) =>
                                                                AlertDialog(
                                                                  title: Text(
                                                                    'Chặn ${item.username} ?',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  content: Text(
                                                                    'Bạn và ${item.username} sẽ không còn nhìn thấy nhau cũng như tương tác trên AntiFacebook!',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            'Cancel');
                                                                      },
                                                                      child: const Text(
                                                                          'Hủy'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        setBlock(
                                                                            int.parse(item.id));
                                                                        Navigator.pop(
                                                                            context,
                                                                            'OK');
                                                                        ScaffoldMessenger.of(context)
                                                                            .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text('Bạn đã chặn ${item.username}'),
                                                                        ));
                                                                      },
                                                                      child: const Text(
                                                                          'Đồng ý'),
                                                                    ),
                                                                  ],
                                                                  surfaceTintColor:
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          162,
                                                                          162,
                                                                          162),
                                                                ));
                                                      },
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
                                                                    .all(10),
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
                                                                fontSize: 14,
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
                                                                    .all(10),
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
                                                                fontSize: 14,
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
                    isLoading
                        ? const SizedBox(
                            height: 300,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(30),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : Container(),
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
