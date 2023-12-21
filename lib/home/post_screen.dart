import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:it4788/core/pallete.dart';
import 'package:it4788/firebase_api/firebase_api.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/profile_sevice.dart';
import 'package:it4788/widgets/post_widget.dart';
import 'package:it4788/service/post_sevice.dart';
import '../widgets/create_post.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  Future<ListPost?>? _future;
  ListPost? listPostResponse;
  PostSevice? postSevice;
  UserInfor? userInfor;
  List<Post> postList = <Post>[];
  int index = 0;
  int count = 20;
  bool isLoading = false;
  bool isConnection = false;
  bool isGetFromCached = false;
  void setDevToken() async {
    FirebaseApi().setDevTokenFirebase();
  }

  @override
  void initState() {
    super.initState();
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        loadMoreData();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
    setDevToken();
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        index += count; // Increment the index to load the next set of data
      });
      var tmp = await postSevice?.getPostList(index, count);

      setState(() {
        postList.addAll(tmp!.data.post);
        isLoading = false;
      });
    }
  }

  Future<String?> _getUserId() async {
    return await Storage().getUserId();
  }

  void getData() async {
    postSevice = PostSevice();
    var userId = await _getUserId();

    if (userId != null) {
      _future = postSevice?.getPostList(index, count);
      Future<UserInfor?> user = ProfileSevice().getUserInfor(userId);
      user.then((value) => {
            setState(() {
              userInfor = value;
            })
          });
    }
  }

  Future<void> cachedPost(String json) async {
    var box = await Hive.openBox('cached_post');
    await box.put('post_list', json);
    print("CACHED NEEEEEEE");
    print(box.get('post_list'));
  }

  void getDataFromCached() async {
    var box = await Hive.openBox('cached_post');
    var tmp = listPostFromJson(box.get('post_list'));

    setState(() {
      postList.addAll(tmp.data.post);
      isGetFromCached = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            postList.isEmpty) {
          return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Palette.facebookBlue,
              ));
        } else if (snapshot.hasData) {
          if (isGetFromCached == true) {
            postList.clear();
          }
          if (postList.isEmpty) {
            listPostResponse = snapshot.data!;
            postList.addAll(listPostResponse!.data.post);
            cachedPost(listPostToJson(snapshot.data!));
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                  child: userInfor != null
                      ? CreatePostContainer(currentUser: userInfor!)
                      : const SizedBox(width: double.infinity, height: 10)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == postList.length) {
                      return const SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return PostWidget(post: postList[index]);
                    }
                  },
                  childCount: postList.length + (isLoading ? 1 : 0),
                ),
              ),
            ],
          );
        } else {
          getDataFromCached();
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                  child: userInfor != null
                      ? CreatePostContainer(currentUser: userInfor!)
                      : const SizedBox(width: double.infinity, height: 10)),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == postList.length) {
                      return const SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return PostWidget(post: postList[index]);
                    }
                  },
                  childCount: postList.length + (isLoading ? 1 : 0),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
