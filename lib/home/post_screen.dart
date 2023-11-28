import 'package:it4788/data/data.dart';
import 'package:flutter/widgets.dart';
import '../widgets/create_post.dart';
import '../widgets/post_widget.dart';

class PostScreen extends StatefulWidget {
  PostScreen({Key? key}) : super(key: key);
  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final ScrollController _scrollController = ScrollController(keepScrollOffset: true);



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: CreatePostContainer(currentUser: currentUser),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return PostWidget(post: posts[index]);
            },
            childCount: posts.length,
          ),
        ),
      ],
    );
  }
}
