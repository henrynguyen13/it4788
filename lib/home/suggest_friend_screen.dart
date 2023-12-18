import 'package:it4788/model/suggest_friends.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/friend_service.dart';
import 'package:flutter/material.dart';
import 'package:it4788/widgets/suggest_friend_card.dart';

class SuggestFriendScreen extends StatefulWidget {
  const SuggestFriendScreen({super.key});

  @override
  State<SuggestFriendScreen> createState() => _SuggestFriendScreenState();
}

class _SuggestFriendScreenState extends State<SuggestFriendScreen> {
  List<SuggestedFriend> suggestedFriendList = <SuggestedFriend>[];
  Future<SuggestedFriendList?>? _future;
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
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void getData() async {
    var userId = await Storage().getUserId();
    if (userId != null) {
      setState(() {
        _future = FriendService().getSuggestFriend(index, count);
      });
    }
  }

  void loadMoreFriends() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        index += count; // Increment the index to load the next set of data
      });
      var tmp = await FriendService().getSuggestFriend(index, count);

      setState(() {
        suggestedFriendList.addAll(tmp!.data);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gợi ý'),
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                suggestedFriendList.isEmpty) {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              if (suggestedFriendList.isEmpty) {
                suggestedFriendList.addAll(snapshot.data!.data);
              }
              return Scaffold(
                body: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      expandedHeight: 50,
                      floating: false,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Những người bạn có thể biết',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: 30.0,
                                      ),
                                    ),
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
                          if (index == suggestedFriendList.length) {
                            return const SizedBox(
                                height: 300,
                                width: double.infinity,
                                child:
                                    Center(child: CircularProgressIndicator()));
                          } else {
                            return SuggestedFriendCard(
                                friend: suggestedFriendList[index]);
                          }
                        },
                        childCount:
                            suggestedFriendList.length + (isLoading ? 1 : 0),
                      ),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator());
            }
          }),
    );
  }
}
