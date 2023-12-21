import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it4788/comment/commentPage.dart';
import 'package:it4788/home/post_detail_screen.dart';
import 'package:it4788/model/video.dart';
import 'package:it4788/post_article/edit_post_article.dart';
import 'package:it4788/service/profile_sevice.dart';
import 'package:video_player/video_player.dart';
// import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final PostVideo post;

  const VideoWidget({super.key, required this.post});
  @override
  State<VideoWidget> createState() {
    return _VideoWidgetState();
  }
}

class _VideoWidgetState extends State<VideoWidget> {
  late PostVideo post;
  late bool isClickKudos;
  late bool isClickDisappointed;
  VideoPlayerController? _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    post = widget.post;
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        post.video!.url!,
      ),
    );
    _initializeVideoPlayerFuture = _videoPlayerController!.initialize();
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
      ProfileSevice().deleteFeelPost(post.id!);
    } else {
      ProfileSevice().feelPost(post.id!, "1");
    }
    setState(() {
      if (isClickDisappointed) {
        isClickDisappointed = false;
        isClickKudos = true;
      } else {
        isClickKudos = !isClickKudos;
      }

      if (post.isFelt == '1') {
        int feelInt = int.parse(post.feel!) - 1;
        post.isFelt = '-1';
        post.feel = feelInt.toString();
      } else if (post.isFelt == '0') {
        post.isFelt = '1';
      } else {
        int feelInt = int.parse(post.feel!) + 1;
        post.isFelt = '1';
        post.feel = feelInt.toString();
      }
    });
  }

  void handleClickDisappointed() async {
    if (post.isFelt == '0') {
      ProfileSevice().deleteFeelPost(post.id!);
    } else {
      ProfileSevice().feelPost(post.id!, "0");
    }
    setState(() {
      if (isClickKudos == true) {
        isClickDisappointed = true;
        isClickKudos = false;
      } else {
        isClickDisappointed = !isClickDisappointed;
      }

      if (post.isFelt == '0') {
        int feelInt = int.parse(post.feel!) - 1;
        post.isFelt = '-1';
        post.feel = feelInt.toString();
      } else if (post.isFelt == '1') {
        post.isFelt = '0';
      } else {
        int feelInt = int.parse(post.feel!) + 1;
        post.isFelt = '0';
        post.feel = feelInt.toString();
      }
    });
  }

  String formatTimeDifference(DateTime from, DateTime to) {
    Duration difference = to.difference(from);
    if (difference.inSeconds < 0) {
      return '0 giây trước';
    } else if (difference.inSeconds < 60) {
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
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Scaffold(
          body: Center(
            child: Stack(alignment: Alignment.center, children: [
              FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return GestureDetector(
                        onTap: () => {},
                        child: Card(
                            elevation: 0,
                            color: Colors.transparent,
                            child: _buildArticleItem(post)),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              Positioned(
                child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 48, 47, 47),
                  tooltip: 'Capture Picture',
                  elevation: 5,
                  splashColor: Colors.grey,
                  onPressed: () {
                    setState(() {
                      // If the video is playing, pause it.
                      if (_videoPlayerController!.value.isPlaying) {
                        _videoPlayerController!.pause();
                      } else {
                        // If the video is paused, play it.
                        _videoPlayerController!.play();
                      }
                    });
                  },
                  // Display the correct icon depending on the state of the player.
                  child: Icon(
                    color: Colors.white,
                    size: 29,
                    _videoPlayerController!.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Widget _buildVideoSection(Video? video) {
    return Container(
      width: MediaQuery.of(context).size.width, // Set your desired width
      height:
          MediaQuery.of(context).size.height * 0.4, // Set your desired height
      child: AspectRatio(
        aspectRatio: _videoPlayerController!.value.aspectRatio,
        child: VideoPlayer(_videoPlayerController!),
      ),
    );
  }

  Widget _buildArticleItem(PostVideo post) {
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
                    child: Image.network(post.author!.avatar!),
                  ),
                ),
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 300,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.author!.name!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(formatTimeDifference(post.created!, DateTime.now())
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
                post.described!,
                style: const TextStyle(fontSize: 16),
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 3,
              ),
            ),
          ),
          _buildVideoSection(post.video),
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
              Text(post.feel!),
              const Spacer(),
              Text("${post.commentMark} bình luận")
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
  PostVideo post;
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
                                    EditPostArticle(id: post.id!),
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
                            onPressed: () => {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) => ReportPage(
                                  //             post: post,
                                  //           )),
                                  // ),
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
