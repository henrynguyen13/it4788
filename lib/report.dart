import 'package:flutter/material.dart';
import 'package:it4788/model/post.dart';

import 'competeReport.dart';

class ReportPage extends StatefulWidget {
  ReportPage({super.key, required this.post});
  Post post;
  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List reportContentList = [
    {
      'content': 'Ảnh khỏa thân',
      'isSelected': 0,
    },
    {
      'content': 'Bạo lực',
      'isSelected': 0,
    },
    {
      'content': 'Quấy rối',
      'isSelected': 0,
    },
    {
      'content': 'Tự tử/Tự gây thương tích',
      'isSelected': 0,
    },
    {
      'content': 'Tin giả',
      'isSelected': 0,
    },
    {
      'content': 'Spam',
      'isSelected': 0,
    },
    {
      'content': 'Bán hàng trái phép',
      'isSelected': 0,
    },
    {
      'content': 'Ngôn từ gây thù ghét',
      'isSelected': 0,
    },
    {
      'content': 'Khủng bố',
      'isSelected': 0,
    },
  ];
  bool isCanContinue = false;

  void checkCanContinue() {
    int cnt = 0;
    for (var i = 0; i < reportContentList.length; i++) {
      if (reportContentList[i]['isSelected'] == 1) {
        cnt++;
        break;
      }
    }
    isCanContinue = cnt > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                size: 30,
                color: Color.fromARGB(255, 141, 141, 141),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            const Text(
              "Vui lòng chọn vấn đề để tiếp tục",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("Bạn có thể báo cáo bài viết sau khi chọn chủ đề"),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child:
                  Wrap(spacing: 8, alignment: WrapAlignment.start, children: [
                for (var i = 0; i < reportContentList.length; i++)
                  Button(
                    content: reportContentList[i]['content'],
                    isSelected: reportContentList[i]['isSelected'] == 1,
                    selectMethod: () => setState(() {
                      reportContentList[i]['isSelected'] =
                          reportContentList[i]['isSelected'] == 1 ? 0 : 1;
                      checkCanContinue();
                    }),
                  )
              ]),
            ),
            const Divider(),
            const Expanded(child: Row()),
            Center(
              child: SizedBox(
                width: 500,
                height: 50,
                child: FilledButton(
                  onPressed: () {
                    if (isCanContinue) {
                      List<String> listContents = <String>[];
                      for (var i = 0; i < reportContentList.length; i++) {
                        if (reportContentList[i]['isSelected'] == 1) {
                          listContents.add(reportContentList[i]['content']);
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComleteReportPage(
                                  selectedContents: listContents,
                                  post: widget.post,
                                )),
                      );
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: isCanContinue
                          ? const MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 58, 72, 255))
                          : const MaterialStatePropertyAll<Color>(
                              Color.fromARGB(255, 226, 226, 226))),
                  child: Text(
                    "Tiếp",
                    style: TextStyle(
                        color: isCanContinue ? Colors.white : Colors.black,
                        fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  final String content;
  bool isSelected;
  dynamic selectMethod;
  Button({
    super.key,
    required this.content,
    required this.isSelected,
    required this.selectMethod,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: selectMethod,
      style: ButtonStyle(
          backgroundColor: isSelected
              ? const MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 58, 72, 255))
              : const MaterialStatePropertyAll<Color>(
                  Color.fromARGB(255, 226, 226, 226))),
      child: Text(
        content,
        style: isSelected
            ? const TextStyle(color: Colors.white)
            : const TextStyle(color: Colors.black),
      ),
    );
  }
}
