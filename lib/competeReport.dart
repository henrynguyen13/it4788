import 'package:flutter/material.dart';

import 'report.dart';

class ComleteReportPage extends StatefulWidget {
  final List<String> selectedContents;
  const ComleteReportPage({super.key, required this.selectedContents});

  @override
  State<ComleteReportPage> createState() => _ComleteReportPageState();
}

class _ComleteReportPageState extends State<ComleteReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Các bước khác mà bạn có thể thực hiện",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {},
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
            SizedBox(
              width: 300,
              child: FilledButton(
                onPressed: () {},
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Color.fromARGB(255, 58, 72, 255))),
                child: const Text(
                  "Xong",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
