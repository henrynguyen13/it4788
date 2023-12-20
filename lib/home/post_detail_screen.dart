import 'package:flutter/material.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/widgets/post_detail_widget.dart';
import 'package:it4788/service/post_sevice.dart';

class PostDetailScreen extends StatefulWidget {
  final String id;
  const PostDetailScreen({Key? key, required this.id}) : super(key: key);
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  PostSevice? postSevice;
  late Future<PostResponse> _futures;
  PostResponse? post;
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    _futures = PostSevice().getPostById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chi tiết bài viết",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: FutureBuilder<PostResponse>(
            future: _futures,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                post = snapshot.data;

                return PostDetailWidget(post: post!);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return const Text('No data available');
              }
            }));
  }
}
