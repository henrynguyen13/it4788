import 'package:it4788/home/suggest_friend_screen.dart';
import 'package:it4788/model/request_friends.dart';
import 'package:it4788/personal_page/all_friend_page.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/friend_service.dart';
import 'package:it4788/widgets/request_friend_card.dart';
import 'package:flutter/material.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  List<RequestFriend>? requestFriendList;
  Future<RequestFriendList?>? _requestFriends;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var userId = await Storage().getUserId();
    if (userId != null) {
      setState(() {
        _requestFriends = FriendService().getFriendRequest(10);
      });
    }
  }

  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  int visibleFriendsCount = 5;
  int maxVisibleFriendCount = 10;

  void loadMoreFriends() {
    setState(() {
      visibleFriendsCount += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _requestFriends,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            requestFriendList = snapshot.data!.data.requests;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 200,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Bạn bè',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24)),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Color.fromARGB(255, 227, 224, 224)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SuggestFriendScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Gợi ý',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Color.fromARGB(255, 227, 224, 224)),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AllFriendPage()),
                                    );
                                  },
                                  child: const Text(
                                    'Tất cả bạn bè',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                              color: Color.fromARGB(255, 178, 176, 176)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Lời mời kết bạn',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      requestFriendList!.length.toString(),
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return RequestFriendCard(
                          friend: requestFriendList![index]);
                    },
                    childCount: requestFriendList!.isNotEmpty
                        ? requestFriendList!.length
                        : 0,
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
  }
}
