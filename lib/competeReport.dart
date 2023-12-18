import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it4788/service/post_sevice.dart';

import 'report.dart';

class ComleteReportPage extends StatefulWidget {
  final List<String> selectedContents;
  ComleteReportPage(
      {super.key, required this.selectedContents, required this.postID});
  int postID;
  @override
  State<ComleteReportPage> createState() => _ComleteReportPageState();
}

class _ComleteReportPageState extends State<ComleteReportPage> {
  final TextEditingController detailsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.report,
              color: Color.fromARGB(255, 255, 225, 0),
              size: 100,
            ),
            const Text(
              "Bạn đã chọn",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child:
                  Wrap(spacing: 8, alignment: WrapAlignment.center, children: [
                for (var i = 0; i < widget.selectedContents.length; i++)
                  Button(
                    content: widget.selectedContents[i],
                    isSelected: true,
                    selectMethod: () {},
                  ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Bạn có thể báo cáo nếu cho rằng nội dung này vi phạm tiêu chuẩn cộng đồng của chúng tôi. Xin lưu ý rằng đội ngũ xét duyệt của chúng tôi hiện có ít nhân lực hơn",
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "Chi tiết ...",
                    border: InputBorder.none,
                  ),
                  controller: detailsController,
                ),
              ),
            ),
            const Divider(),
            const Text(
              "Các bước khác mà bạn có thể thực hiện",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                      Color.fromARGB(255, 242, 242, 242))),
              child: const Row(
                children: [
                  Image(
                    image:
                        AssetImage("assets/images/icons/user_block_icon.png"),
                    width: 40,
                    height: 40,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Chặn User",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Các bạn sẽ không thể nhìn thấy hoặc liên hệ với nhau",
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 93, 93, 93),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: Row()),
            SizedBox(
              width: 300,
              height: 50,
              child: FilledButton(
                onPressed: () {
                  String subject = "";
                  for (var i = 0; i < widget.selectedContents.length; i++) {
                    subject += "${widget.selectedContents[i]} ";
                  }
                  PostSevice().reportPost(
                      widget.postID, subject, detailsController.text);
                },
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 58, 72, 255))),
                child: const Text(
                  "Báo cáo",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }
}
