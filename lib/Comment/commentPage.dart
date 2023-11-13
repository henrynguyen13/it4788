// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';

import 'comment.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> with WidgetsBindingObserver {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  late FocusNode focusNode;
  late bool isShowSendWidget = false;
  int replyingCommentId = -1;

  List<CommentModel> filedata = <CommentModel>[
    CommentModel(
      id: 0,
      name: 'Hiếu',
      pic: 'assets/images/icons/avatar_icon.png',
      message: 'Tôi thích uống bia',
      date: '20p',
      childrenIdList: [1, 2],
      parentId: -1,
    ),
    CommentModel(
      id: 1,
      name: 'Khoa',
      pic: 'assets/images/icons/avatar_icon.png',
      message: 'Haha',
      date: '4h',
      childrenIdList: [],
      parentId: 0,
    ),
    CommentModel(
      id: 2,
      name: 'Mạnh',
      pic: 'assets/images/icons/avatar_icon.png',
      message: 'Mèo méo meo',
      date: '8h',
      childrenIdList: [],
      parentId: 0,
    ),
    CommentModel(
      id: 3,
      name: 'Huy',
      pic: 'assets/images/icons/avatar_icon.png',
      message: 'Very cool',
      date: '1 ngày',
      childrenIdList: [],
      parentId: -1,
    ),
  ];
  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    // ignore: deprecated_member_use
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (value == 0) {
      focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    focusNode.dispose();
    super.dispose();
  }

  void ontapMethod(int parentId) {
    setState(() {
      isShowSendWidget = true;
      replyingCommentId = parentId;
    });
  }

  Widget commentChild(data) {
    return ListView(
        padding: const EdgeInsets.fromLTRB(
          0,
          10,
          0,
          0,
        ),
        scrollDirection: Axis.vertical,
        children: [
          for (var i = data.length - 1; i >= 0; i--)
            if (data[i].parentId == -1) commentObject(data, i, 50),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("(React count)"),
        backgroundColor: Colors.white,
      ),
      body: CommentBox(
        userImage: CommentBox.commentImageParser(
            imageURLorPath: "assets/images/icons/avatar_icon.png"),
        placeHolder: 'Viết bình luận...',
        errorText: 'Comment cannot be blank',
        withBorder: false,
        sendButtonMethod: () {
          if (formKey.currentState!.validate()) {
            setState(() {
              var newComment = CommentModel(
                id: filedata.length,
                name: 'Hoàng',
                pic: 'assets/images/icons/avatar_icon.png',
                message: commentController.text,
                date: 'Vừa xong',
                childrenIdList: [],
                parentId: replyingCommentId,
              );
              if (replyingCommentId >= 0) {
                filedata[replyingCommentId].childrenIdList.insert(
                    filedata[replyingCommentId].childrenIdList.length,
                    filedata.length);
              }
              filedata.insert(filedata.length, newComment);
            });
            commentController.clear();
            FocusScope.of(context).unfocus();
          }
        },
        onTapMethod: () {
          ontapMethod(-1);
        },
        formKey: formKey,
        commentController: commentController,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        sendWidget: Visibility(
          visible: isShowSendWidget,
          child: const Icon(
            Icons.send_sharp,
            size: 30,
            color: Color.fromRGBO(57, 104, 214, 1),
          ),
        ),
        focusNode: focusNode,
        child: commentChild(filedata),
      ),
    );
  }

  Row commentObject(List data, int index, double avatarSize) {
    //GlobalKey childKey = GlobalKey();
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
                backgroundImage: CommentBox.commentImageParser(
                    imageURLorPath: data[index].pic)),
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data[index].name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data[index].message,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(mainAxisSize: MainAxisSize.max, children: [
              const SizedBox(width: 10), //Space
              Text(
                data[index].date,
              ),
              const SizedBox(width: 5), //Space
              SizedBox(
                height: 35,
                child: TextButton(
                  onPressed: () {
                    focusNode.requestFocus();
                    ontapMethod(data[index].id);
                  },
                  child: const Text(
                    'Trả lời',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ]),
            if (data[index].childrenIdList.length > 0)
              for (var j = 0; j < data[index].childrenIdList.length; j++)
                commentObject(data, data[index].childrenIdList[j], 40),
            // if ((data[i]['children']) > 0)
            //   CustomPaint(
            //     painter: CommentTreePainter(
            //         curvedRadius: 20, parentKey: _key, childKey: childKey),
            //   )
          ],
        ),
      ],
    );
  }
}

class CommentModel {
  int id;
  String name;
  String pic;
  String message;
  String date;
  List<int> childrenIdList;
  int parentId;

  CommentModel({
    required this.id,
    required this.name,
    required this.pic,
    required this.message,
    required this.date,
    required this.childrenIdList,
    required this.parentId,
  });
}
