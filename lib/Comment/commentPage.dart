import 'dart:math';

import 'package:flutter/material.dart';

import 'package:it4788/comment/commentBox.dart';
import 'package:it4788/model/mark_comment.dart';
import 'package:it4788/service/authStorage.dart';
import 'package:it4788/service/comment_service.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key, required this.postID});

  final postID;
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with WidgetsBindingObserver {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  var newestCommentKey;
  Future<List<Mark>?>? _future;
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
    _future = getMarkComment(
        widget.postID, '0', ((currentIndex + 1) * defaultCount).toString());
    _avatar = await Storage().getAvatar();
  }

  @override
  void initState() {
    super.initState();
    getAllMark();
    replyingMarkId = -1;
    isShowingReplyComment = false;
    repylingUsername = "";
    isTruth = 1;
    currentIndex = 0;
    WidgetsBinding.instance.addObserver(this);
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
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Bình luận"),
                  backgroundColor: Colors.white,
                ),
                body: ListView(
                    padding: const EdgeInsets.fromLTRB(
                      0,
                      10,
                      0,
                      0,
                    ),
                    scrollDirection: Axis.vertical,
                    children: [
                      for (var i = 0; i < 5; i++) emptyMarkWidget(),
                    ]));
          } else if (snapshot.hasData) {
            listMark = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: const Text("Bình luận"),
                backgroundColor: Colors.white,
              ),
              body: CommentBox(
                userImage: CommentBox.commentImageParser(
                    imageURLorPath: NetworkImage(_avatar)),
                placeHolder: 'Viết bình luận...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () async {
                  if (formKey.currentState!.validate()) {
                    if (replyingMarkId != -1) {
                      _future = setComment(
                          widget.postID,
                          commentController.text,
                          '0',
                          ((currentIndex + 1) * defaultCount).toString(),
                          replyingMarkId.toString());
                    } else {
                      _future = setMark(
                          widget.postID,
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
                    listMark.length >= (currentIndex + 1) * defaultCount,
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
                child: markList(listMark),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator());
          }
        });
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
