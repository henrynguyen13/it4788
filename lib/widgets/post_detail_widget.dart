import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it4788/comment/commentPage.dart';
import 'package:it4788/model/post.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/post_article/edit_post_article.dart';
import 'package:it4788/post_article/image_detail_screen.dart';
import 'package:it4788/report.dart';
import 'package:it4788/service/profile_sevice.dart';

class PostDetailWidget extends StatefulWidget {
  final PostResponse post;
  final Function? click;
  const PostDetailWidget({super.key, required this.post, this.click});
  @override
  State<PostDetailWidget> createState() {
    return _PostDetailWidgetState();
  }
}

class _PostDetailWidgetState extends State<PostDetailWidget> {
  late PostResponseData post;
  late bool isClickKudos;
  late bool isClickDisappointed;
  late String feel;
  @override
  void initState() {
    super.initState();
    post = widget.post.data;
    feel = (int.parse(post.disappointed) + int.parse(post.kudos)).toString();
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
    if (post.isFelt == '1') {
      ProfileSevice().deleteFeelPost(post.id);
    } else {
      ProfileSevice().feelPost(post.id, "1");
    }
    setState(() {
      if (isClickDisappointed) {
        isClickDisappointed = false;
        isClickKudos = true;
      } else {
        isClickKudos = !isClickKudos;
      }

      if (post.isFelt == '1') {
        int feelInt = int.parse(feel) - 1;
        post.isFelt = '-1';
        feel = feelInt.toString();
      } else if (post.isFelt == '0') {
        post.isFelt = '1';
      } else {
        int feelInt = int.parse(feel) + 1;
        post.isFelt = '1';
        feel = feelInt.toString();
      }
    });
  }

  void handleClickDisappointed() async {
    if (post.isFelt == '0') {
      ProfileSevice().deleteFeelPost(post.id);
    } else {
      ProfileSevice().feelPost(post.id, "0");
    }
    setState(() {
      if (isClickKudos == true) {
        isClickDisappointed = true;
        isClickKudos = false;
      } else {
        isClickDisappointed = !isClickDisappointed;
      }

      if (post.isFelt == '0') {
        int feelInt = int.parse(feel) - 1;
        post.isFelt = '-1';
        feel = feelInt.toString();
      } else if (post.isFelt == '1') {
        post.isFelt = '0';
      } else {
        int feelInt = int.parse(feel) + 1;
        post.isFelt = '0';
        feel = feelInt.toString();
      }
    });
  }

  String formatTimeDifference(DateTime from, DateTime to) {
    Duration difference = to.difference(from);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} giây trước';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return '${difference.inDays} ngày trước';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {widget.click != null ? widget.click!() : null},
      child: Card(
          elevation: 0,
          color: Colors.transparent,
          child: _buildArticleItem(post)),
    );
  }

  Widget _buildImageSection(List<PostImage> images) {
    if (images.length == 1) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDetailScreen(
                // imageUrls: images.map((image) => image!.url).toList(),
                images: images,
                initialPage: 0,
                onImageRemoved: (removedIndex, id) {
                  setState(() {});
                },
              ),
            ),
          );
        },
        child: Image.network(images[0]!.url,
            height: 400, width: double.infinity, fit: BoxFit.cover),
      );
    } else if (images.length == 2 || images.length == 4) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailScreen(
                    // imageUrls: images.map((image) => image!.url).toList(),
                    images: images,
                    initialPage: index,
                    onImageRemoved: (removedIndex, id) {
                      setState(() {});
                    },
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Image.network(images[index]!.url,
                  height: 200, width: double.infinity, fit: BoxFit.cover),
            ),
          );
        },
      );
    } else if (images.length == 3) {
      return Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageDetailScreen(
                      images: images,
                      initialPage: 0,
                      onImageRemoved: (removedIndex, id) {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              child:
                  Image.network(images[0]!.url, height: 400, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailScreen(
                            images: images,
                            initialPage: 1,
                            onImageRemoved: (removedIndex, id) {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    child: Image.network(images[1]!.url,
                        height: 198, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, top: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDetailScreen(
                            images: images,
                            initialPage: 2,
                            onImageRemoved: (removedIndex, id) {
                              setState(() {});
                            },
                          ),
                        ),
                      );
                    },
                    child: Image.network(images[2]!.url,
                        height: 198, width: double.infinity, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildArticleItem(PostResponseData post) {
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
              Expanded(
                child: BottomPopup(
                  post: post,
                ),
              )
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
              const Stack(
                alignment: AlignmentDirectional.centerStart,
                children: [
                  Image(
                    image: AssetImage("assets/images/icons/heart.png"),
                    width: 24,
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image(
                      image: AssetImage("assets/images/icons/sad.png"),
                      width: 21,
                      height: 21,
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(right: 4)),
              Text(feel),
              const Spacer(),
              Text("0 bình luận")
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
                            const Image(
                              image:
                                  AssetImage("assets/images/icons/heart.png"),
                              width: 26,
                              height: 26,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              'Yêu thích',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isClickKudos
                                      ? const Color.fromARGB(255, 232, 43, 29)
                                      : Colors.black),
                            ),
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
                            const Image(
                              image: AssetImage("assets/images/icons/sad.png"),
                              width: 24,
                              height: 24,
                            ),
                            const Padding(padding: EdgeInsets.only(right: 8)),
                            Text(
                              'Buồn',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: isClickDisappointed
                                      ? const Color.fromARGB(255, 255, 187, 1)
                                      : Colors.black),
                            ),
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
                            FaIcon(
                              FontAwesomeIcons.comment,
                              size: 24,
                            ),
                            Padding(padding: EdgeInsets.only(right: 8)),
                            Text('Bình luận',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                )),
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

// ignore: must_be_immutable
class BottomPopup extends StatelessWidget {
  BottomPopup({super.key, required this.post});
  PostResponseData post;
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
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditPostArticle(id: post.id),
                              ),
                            );
                          },
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
                            onPressed: () => {}),
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
