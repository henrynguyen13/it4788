import 'package:flutter/material.dart';
import 'package:it4788/core/pallete.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/service/post_sevice.dart';
import 'package:it4788/service/search_service.dart';
import 'package:it4788/widgets/post_detail_widget.dart';
import 'package:it4788/widgets/post_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isDark = false;
  Future<List<String>?>? _future;
  List<String> listPostId = <String>[];

  Widget postDetailWidgetList(String postId) {
    Future<PostResponse> _post = PostSevice().getPostById(postId);
    return FutureBuilder(
        future: _post,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              listPostId.isEmpty) {
            return const Column();
          } else if (snapshot.hasData) {
            PostResponse post = snapshot.data!;
            return PostDetailWidget(post: post);
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return SizedBox();
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tìm kiếm bài viết')),
        body: Column(children: [
          SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
              child: SearchBar(
                controller: controller,
                padding: const MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                leading: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("search");
                      setState(() {
                        _future = SearchService()
                            .searchPost(controller.text, "841", 0, 10);
                      });
                    }),
              ),
            );
          }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
            return List<ListTile>.generate(5, (int index) {
              final String item = 'item $index';
              return ListTile(
                title: Text(item),
                onTap: () {
                  setState(() {
                    controller.closeView(item);
                  });
                },
              );
            });
          }),
          Expanded(
            child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      listPostId.isEmpty) {
                    return const Column();
                  } else if (snapshot.hasData) {
                    listPostId = snapshot.data!;

                    print(listPostId.length);
                    if (listPostId.length > 0) {
                      return ListView(
                        children: [
                          for (int i = 0; i < listPostId.length; i++)
                            postDetailWidgetList(listPostId[i])
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text("Không tìm thấy kết quả"),
                      );
                    }
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return SizedBox();
                  }
                }),
          )
        ]),
      ),
    );
  }
}
