import 'package:it4788/model/request_friends.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/friend_service.dart';
import 'package:it4788/widgets/friend_card.dart';
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
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return FriendCard(friend: requestFriendList![index]);
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
