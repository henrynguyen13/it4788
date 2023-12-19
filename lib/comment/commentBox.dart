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
  bool isVisibleReply;
  String? userReplying;
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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
