import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:it4788/comment/commentPage.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/report.dart';
import 'package:it4788/service/profile_sevice.dart';

class PostWidget extends StatefulWidget {
  final Post post;
  const PostWidget({super.key, required this.post});
  @override
  State<PostWidget> createState() {
    return _PostWidgetState();
  }
}

class _PostWidgetState extends State<PostWidget> {
  late Post post;
  late bool isClickKudos;
  late bool isClickDisappointed;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    if (post.isFelt == "-1") {
      isClickKudos = false;
      isClickDisappointed = false;
    } else if (post.isFelt == "0") {
      isClickKudos = false;
      isClickDisappointed = true;
    } else {
      isClickKudos = true;
      isClickDisappointed = false;
    }
  }

  void handleClickKudos() async {
    if (isClickDisappointed) return;
    if (post.isFelt == '1') {
      ProfileSevice().deleteFeelPost(post.id);
    } else {
      ProfileSevice().feelPost(post.id, "1");
    }
    setState(() {
      isClickKudos = !isClickKudos;
      if (post.isFelt == '1') {
        int feelInt = int.parse(post.feel) - 1;
        post.isFelt = '-1';
        post.feel = feelInt.toString();
      } else {
        int feelInt = int.parse(post.feel) + 1;
        post.isFelt = '1';
        post.feel = feelInt.toString();
      }
    });
  }

  void handleClickDisappointed() async {
    if (isClickKudos) return;
    if (post.isFelt == '0') {
      ProfileSevice().deleteFeelPost(post.id);
    } else {
      ProfileSevice().feelPost(post.id, "0");
    }
    setState(() {
      isClickDisappointed = !isClickDisappointed;
      if (post.isFelt == '0') {
        int feelInt = int.parse(post.feel) - 1;
        post.isFelt = '-1';
        post.feel = feelInt.toString();
      } else {
        int feelInt = int.parse(post.feel) + 1;
        post.isFelt = '0';
        post.feel = feelInt.toString();
      }
    });
  }

  String formatTimeDifference(DateTime from, DateTime to) {
    Duration difference = to.difference(from);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      int days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 0,
        color: Colors.transparent,
        child: _buildArticleItem(post));
  }

  Widget _buildImageSection(List<ImagePost> images) {
    if (images.length == 1) {
      return Image.network(images[0].url,
          height: 400, width: double.infinity, fit: BoxFit.cover);
    } else if (images.length == 2) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Image.network(images[index].url,
                height: 400, width: double.infinity, fit: BoxFit.cover),
          );
        },
      );
    } else if (images.length == 3) {
      return Row(
        children: [
          Expanded(
            child: Image.network(images[0].url, height: 400, fit: BoxFit.cover),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Image.network(images[1].url,
                      height: 198, width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 2),
                  child: Image.network(images[1].url,
                      height: 198, width: double.infinity, fit: BoxFit.cover),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (images.length >= 4) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1),
            child: Image.network(images[index].url,
                height: 200, width: double.infinity, fit: BoxFit.cover),
          );
        },
      );
    } else {
      return Container();
    }
  }

  Widget _buildArticleItem(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ClipOval(
                  child: CircleAvatar(
                    backgroundColor: Colors.brown.shade800,
                    radius: 28,
                    child: Image.network(post.author.avatar),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 260,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(formatTimeDifference(post.created, DateTime.now())
                            .toString()),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text('.'),
                        ),
                        const Icon(Icons.public)
                      ],
                    )
                  ],
                ),
              ),
              // const Spacer(),
              const Padding(
                  padding: EdgeInsets.only(right: 8), child: BottomPopup())
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.topLeft,
              child: ExpandableText(
                post.described,
                style: const TextStyle(fontSize: 16),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 3,
              ),
            ),
          ),
          _buildImageSection(post.image),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 232, 43, 29),
              ),
              const Icon(
                Icons.mood_bad_rounded,
              ),
              Text(post.feel),
              const Spacer(),
              Text("${post.commentMark} comments")
            ]),
          ),
          const Divider(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleClickKudos();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite,
                                color: isClickKudos
                                    ? Color.fromARGB(255, 232, 43, 29)
                                    : Colors.black),
                            const Padding(padding: EdgeInsets.only(right: 4)),
                            const Text('kudos'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          handleClickDisappointed();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.mood_bad_outlined,
                                color: isClickDisappointed
                                    ? Color.fromARGB(255, 232, 208, 29)
                                    : Colors.black),
                            const Padding(padding: EdgeInsets.only(right: 4)),
                            Text('disappointed'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentPage(
                                      postID: post.id,
                                    )),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.message_outlined),
                            Padding(padding: EdgeInsets.only(right: 4)),
                            Text('comment'),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
              width: double.infinity,
              height: 10,
              child: DecoratedBox(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 195, 193, 192)),
              ))
        ],
      ),
    );
  }
}

class BottomPopup extends StatelessWidget {
  const BottomPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 50,
        height: 50,
        child: TextButton(
          child: const Icon(Icons.more_horiz),
          onPressed: () {
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 300,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.notifications_off_rounded),
                              ),
                              Text('Tắt thông báo về bài viết này'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.save_alt_rounded),
                              ),
                              Text('Lưu bài viết'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.delete),
                              ),
                              Text('Xóa'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.edit),
                              ),
                              Text('Chỉnh sửa bài viết'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(Icons.link),
                              ),
                              Text('Sao chép liên kết'),
                            ],
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                            child: const Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Icon(Icons.error),
                                ),
                                Text('Báo cáo bài viết'),
                              ],
                            ),
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ReportPage()),
                                  ),
                                }),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
