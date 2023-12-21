import 'dart:math';

import 'package:flutter/material.dart';
import 'package:it4788/comment/commentBox.dart';
import 'package:it4788/model/mark_comment.dart';
import 'package:it4788/model/post_response.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/comment_service.dart';
import 'package:it4788/widgets/post_detail_widget.dart';
import 'package:it4788/service/post_sevice.dart';

class PostDetailScreen extends StatefulWidget {
  final String id;
  const PostDetailScreen({Key? key, required this.id}) : super(key: key);
  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen>
    with WidgetsBindingObserver {
  //Post
  PostSevice? postSevice;
  late Future<PostResponse> _futuresPost;
  PostResponse? post;

  //Comment
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  var newestCommentKey;
  Future<List<Mark>?>? _futureMark;
  List<Mark> listMark = <Mark>[];

  int replyingMarkId = -1;
  String repylingUsername = "";
  bool isShowingReplyComment = false;
  int isTruth = 1;
  String truthText = "Tin chính xác";
  var _avatar;

  int currentIndex = 0;
  int defaultCount = 3;

  Future<void> getAllMark() async {
    _futureMark = getMarkComment(
        widget.id, '0', ((currentIndex + 1) * defaultCount).toString());
    _avatar = await Storage().getAvatar();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    focusNode.dispose();
    super.dispose();
  }

  Widget markList(data) {
    return ListView(
        padding: const EdgeInsets.fromLTRB(
          0,
          10,
          0,
          0,
        ),
        scrollDirection: Axis.vertical,
        children: [
          for (var i = data.length - 1; i >= 0; i--) markWidget(data, i, 40),
        ]);
  }

  @override
  void initState() {
    super.initState();
    getData();
    getAllMark();
  }

  void getData() async {
    _futuresPost = PostSevice().getPostById(widget.id);
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
      body: CommentBox(
        // userImage: CommentBox.commentImageParser(
        //     imageURLorPath: NetworkImage(_avatar)),
        placeHolder: 'Viết bình luận...',
        errorText: 'Comment cannot be blank',
        withBorder: false,
        sendButtonMethod: () async {
          if (formKey.currentState!.validate()) {
            if (replyingMarkId != -1) {
              _futureMark = setComment(
                  widget.id,
                  commentController.text,
                  '0',
                  ((currentIndex + 1) * defaultCount).toString(),
                  replyingMarkId.toString());
            } else {
              _futureMark = setMark(
                  widget.id,
                  commentController.text,
                  '0',
                  ((currentIndex + 1) * defaultCount).toString(),
                  isTruth.toString());
            }
            setState(() {
              isShowingReplyComment = false;
              replyingMarkId = -1;
              repylingUsername = "";
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
          }
        },
        onCloseReplyText: () {
          setState(() {
            isShowingReplyComment = false;
            replyingMarkId = -1;
          });
        },
        userReplying: repylingUsername,
        formKey: formKey,
        focusNode: focusNode,
        commentController: commentController,
        selectTruth: () {
          setState(() {
            isTruth = 1;
            truthText = "Tin chính xác";
          });
        },

        selectFake: () {
          setState(() {
            isTruth = 0;
            truthText = "Tin giả";
          });
        },
        showMoreMethod: () {
          currentIndex++;
          getAllMark();
          setState(() {
            isShowingReplyComment = false;
            replyingMarkId = -1;
            repylingUsername = "";
          });
        },
        isVisibleReply: isShowingReplyComment,
        isVisibleShowMoreComment:
            listMark!.length >= (currentIndex + 1) * defaultCount,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        truthText: truthText,
        sendWidget: const Visibility(
          visible: true,
          child: Icon(
            Icons.send_sharp,
            size: 30,
            color: Color.fromRGBO(57, 104, 214, 1),
          ),
        ),
        //focusNode: focusNode,
        child: ListView(children: [
          FutureBuilder<PostResponse>(
              future: _futuresPost,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                      height: 300,
                      child: Align(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator()));
                } else if (snapshot.hasData) {
                  post = snapshot.data;

                  return PostDetailWidget(post: post!);
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No data available');
                }
              }),
          FutureBuilder(
              future: _futureMark,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(children: [
                    for (var i = 0; i < 5; i++) emptyMarkWidget(),
                  ]);
                } else if (snapshot.hasData) {
                  List<Mark>? listMark = snapshot.data;

                  return Column(
                    children: [
                      for (var i = listMark!.length - 1; i >= 0; i--)
                        markWidget(listMark, i, 40),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Text('No data available');
                }
              })
        ]),
      ),
    );
  }

  Widget markWidget(List data, int index, double avatarSize) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
              height: avatarSize,
              width: avatarSize,
              //key: _key,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(avatarSize))),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(data[index].poster.avatar),
              )),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 300),
              decoration: BoxDecoration(
                color: const Color(0x72DDDDDD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data[index].poster.name,
                          //"${data[index].poster.name}  ${(data[index].typeOfMark == "1") ? "   Đánh giá: Tin chính xác" : "   Đánh giá: Tin giả"}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Chip(
                          backgroundColor: (data[index].typeOfMark == "1")
                              ? const Color.fromARGB(255, 205, 255, 219)
                              : const Color.fromARGB(255, 255, 183, 183),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelPadding: EdgeInsets.all(0),
                          avatar: Container(
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                                color: (data[index].typeOfMark == "1")
                                    ? Colors.greenAccent[400]
                                    : Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(14))),
                            child: Icon(
                              (data[index].typeOfMark == "1")
                                  ? Icons.check
                                  : Icons.close,
                              color: (data[index].typeOfMark == "1")
                                  ? const Color.fromARGB(255, 205, 255, 219)
                                  : const Color.fromARGB(255, 255, 183, 183),
                              size: 14,
                            ),
                          ),
                          label: Text(
                            (data[index].typeOfMark == "1")
                                ? "Tin thật"
                                : "Tin giả",
                            style: TextStyle(
                              fontSize: 10,
                              color: (data[index].typeOfMark == "1")
                                  ? Colors.greenAccent[400]
                                  : Colors.red,
                            ),
                          ), //Text
                        ), //Chip
                      ],
                    ),
                    Text(
                      data[index].markContent,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
            Row(mainAxisSize: MainAxisSize.max, children: [
              const SizedBox(width: 10), //Space
              Text(
                formatTimeDifferenceToNow(
                    DateTime.parse(data[index].createdTime)),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 5), //Space
              SizedBox(
                height: 35,
                child: TextButton(
                  onPressed: () {
                    focusNode.requestFocus();

                    setState(() {
                      isShowingReplyComment = true;
                      replyingMarkId = int.parse(data[index].id);
                      repylingUsername = data[index].poster.name;
                    });
                  },
                  child: const Text(
                    'Trả lời',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ]),
            if (data[index].comments.length > 0)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < data[index].comments.length; i++)
                    commentWidget(data[index].comments, i, avatarSize)
                ],
              )
          ],
        ),
      ],
    );
  }

  Widget commentWidget(List data, int index, double avatarSize) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
            height: avatarSize,
            width: avatarSize,
            //key: _key,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(avatarSize))),
            child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(data[index].poster.avatar)),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 100, maxWidth: 250),
              decoration: BoxDecoration(
                color: const Color(0x72DDDDDD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].poster.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data[index].commentContent,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              formatTimeDifferenceToNow(
                  DateTime.parse(data[index].createdTime)),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }

  Widget emptyMarkWidget() {
    var list = [40.0, 80.0, 120.0];
    double heightRandom = list[Random().nextInt(list.length)];
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Container(
            height: 50,
            width: 50,
            //key: _key,
            decoration: const BoxDecoration(
                color: Color(0x72DDDDDD),
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0x72DDDDDD),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
                child: SizedBox(
                  width: 200,
                  height: heightRandom,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ],
    );
  }

  String formatTimeDifferenceToNow(DateTime from) {
    Duration difference = DateTime.now().difference(from);

    if (difference.inSeconds < 0) {
      return 'Vừa xong';
    } else if (difference.inSeconds < 60) {
      return 'Vừa xong';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      int days = difference.inDays;
      return '$days ngày trước';
    }
  }
}
