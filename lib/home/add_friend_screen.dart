import 'package:it4788/model/user_friends.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/friend_service.dart';
import 'package:it4788/widgets/friend_card.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  List<Friend>? userFriendList;
  Future<UserFriends?>? _userFriendFuture;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var userId = await Storage().getUserId();
    if (userId != null) {
      setState(() {
        _userFriendFuture = FriendService().getFriendRequest(10);
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
        future: _userFriendFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            userFriendList = snapshot.data!.data.friends;
            return CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index < visibleFriendsCount) {
                        return FriendCard(friend: userFriendList![index]);
                      } else if (index == visibleFriendsCount &&
                          index != maxVisibleFriendCount) {
                        return Column(
                          children: [
                            FriendCard(friend: userFriendList![index]),
                            ElevatedButton(
                              onPressed: loadMoreFriends,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('Load More Friends'),
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            )
                          ],
                        );
                      } else {
                        return Container(); // Empty container for other indexes
                      }
                    },
                    childCount: visibleFriendsCount +
                        1, // Add 1 for the "Load More" button
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
