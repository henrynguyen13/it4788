import 'package:flutter/material.dart';
import 'package:it4788/data/data.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/user_infor_profile.dart';
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
  late Future<ListPost?> _future;
  late ListPost listPost;
  UserInfor? userInfor;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _future = PostSevice().getPostList('668');
    Future<UserInfor?> user = ProfileSevice().getUserInfor('668');
    user.then((value) => {
          setState(() {
            userInfor = value;
          })
        });
  }

  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          listPost = snapshot.data!;

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
                    return PostWidget(post: listPost.data.post[index]);
                  },
                  childCount: listPost.data.post.length,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('No data available');
        }
      },
    );
  }
}
