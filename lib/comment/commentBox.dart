// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CommentBox extends StatelessWidget {
  Widget? child;
  dynamic formKey;
  dynamic sendButtonMethod;
  dynamic onTapMethod;
  dynamic onCloseReplyText;
  dynamic commentController;
  dynamic selectTruth;
  dynamic selectFake;
  bool isVisibleReply;
  String? userReplying;
  String truthText;
  ImageProvider? userImage;
  String? labelText;
  String? placeHolder;
  String? errorText;
  Widget? sendWidget;
  Color? backgroundColor;
  Color? textColor;
  bool withBorder;
  Widget? header;
  FocusNode? focusNode;
  CommentBox({
    this.child,
    this.header,
    this.sendButtonMethod,
    this.onTapMethod,
    this.onCloseReplyText,
    this.formKey,
    this.commentController,
    this.selectTruth,
    this.selectFake,
    required this.isVisibleReply,
    this.sendWidget,
    this.userReplying,
    this.userImage,
    this.labelText,
    this.placeHolder,
    this.focusNode,
    this.errorText,
    this.withBorder = true,
    this.backgroundColor,
    this.textColor,
    required this.truthText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
            onPressed: () {},
            child: const Text(
              "Xem thêm bình luận",
              style: TextStyle(color: Colors.black),
            )),
        Expanded(child: child!),
        Visibility(
          visible: isVisibleReply,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: onCloseReplyText,
                        icon: const Icon(Icons.close)),
                    Text(
                      "Đang trả lời $userReplying",
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Visibility(
          visible: !isVisibleReply,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                height: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: selectTruth,
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.greenAccent[400],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Tin chính xác",
                          style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                    height: 50,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 169, 169, 169)),
                    ),
                  ),
                  TextButton(
                    onPressed: selectFake,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.close,
                          color: Color.fromARGB(255, 255, 0, 0),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Tin giả        ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        header ?? const SizedBox.shrink(),
        ListTile(
          tileColor: backgroundColor,
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 54, 176, 24),
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: CircleAvatar(radius: 50, backgroundImage: userImage),
          ),
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              focusNode: focusNode,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration(
                enabledBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor!),
                      ),
                focusedBorder: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor!),
                      ),
                border: !withBorder
                    ? InputBorder.none
                    : UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor!),
                      ),
                labelText: labelText,
                hintText: placeHolder,
                focusColor: textColor,
                fillColor: textColor,
                labelStyle: TextStyle(color: textColor),
              ),
              validator: (value) => value!.isEmpty ? errorText : null,
              onTap: onTapMethod,
            ),
          ),
          subtitle: Visibility(
            visible: !isVisibleReply,
            child: Text(truthText),
          ),
          trailing: GestureDetector(
            onTap: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }

  static ImageProvider commentImageParser({imageURLorPath}) {
    try {
      //check if imageURLorPath
      if (imageURLorPath is String) {
        return AssetImage(imageURLorPath);
      } else {
        return imageURLorPath;
      }
    } catch (e) {
      //throw error
      throw Exception('Error parsing image: $e');
    }
  }
}
