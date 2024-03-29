import 'package:flutter/material.dart';
import 'package:it4788/core/pallete.dart';
import 'package:it4788/firebase_api/firebase_api.dart';
import 'package:it4788/model/user_infor_profile.dart';
import 'package:it4788/model/video.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/profile_sevice.dart';
import 'package:it4788/widgets/post_widget.dart';
import 'package:it4788/service/post_sevice.dart';
import 'package:it4788/widgets/video_widget.dart';
import '../widgets/create_post.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  Future<ListVideo?>? _future;
  ListVideo? listVideoResponse;
  PostSevice? postSevice;
  UserInfor? userInfor;
  List<PostVideo> videoList = <PostVideo>[];
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
        loadMoreData();
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  void loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        index += count; // Increment the index to load the next set of data
      });
      var tmp = await postSevice?.getListVideos(index, count);

      setState(() {
        videoList.addAll(tmp!.data!.post!);
        isLoading = false;
      });
    }
  }

  void getData() async {
    postSevice = PostSevice();
    _future = postSevice?.getListVideos(index, count);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            videoList.isEmpty) {
          return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                color: Palette.facebookBlue,
              ));
        } else if (snapshot.hasData) {
          if (videoList.isEmpty) {
            listVideoResponse = snapshot.data!;
            videoList.addAll(listVideoResponse!.data!.post!);
          }

          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == videoList.length) {
                      return const SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: Center(child: CircularProgressIndicator()));
                    } else {
                      return VideoWidget(post: videoList[index]);
                    }
                  },
                  childCount: videoList.length + (isLoading ? 1 : 0),
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        }
      },
    );
  }
}
