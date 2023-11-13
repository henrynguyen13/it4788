import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it4788/post_article/feelings_activities/table_cell.dart';
import 'package:it4788/post_article/post_article.dart';

class PickerFeelings extends StatelessWidget {
  const PickerFeelings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(172, 138, 92, 156),
          title: const Text(
            "Bạn cảm thấy thế nào ?",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.cancel_outlined,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostArticle()),
                  );
                },
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Table(
            border: TableBorder.all(color: Colors.grey),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const <TableRow>[
              TableRow(children: <Widget>[
                TableCellWidget(
                  height: 64,
                  color: Color.fromRGBO(230, 9, 9, 0.7),
                  icon: FontAwesomeIcons.faceGrinHearts,
                  text: "đang yêu",
                ),
                TableCellWidget(
                  height: 64,
                  color: Color.fromRGBO(243, 96, 4, 0.8),
                  icon: FontAwesomeIcons.faceAngry,
                  text: "tức giận",
                ),
              ]),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 9, 230, 0.7),
                    icon: FontAwesomeIcons.faceDizzy,
                    text: "chóng mặt",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 230, 42, 0.698),
                    icon: FontAwesomeIcons.faceGrinStars,
                    text: "hứng thú",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(236, 4, 236, 0.694),
                    icon: FontAwesomeIcons.faceFrown,
                    text: "thất vọng",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(4, 181, 235, 0.69),
                    icon: FontAwesomeIcons.faceSmileWink,
                    text: "tự tin",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 83, 9, 0.86),
                    icon: FontAwesomeIcons.faceFlushed,
                    text: "vô tri",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 9, 90, 0.698),
                    icon: FontAwesomeIcons.faceFrownOpen,
                    text: "nghi ngờ",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 230, 123, 0.835),
                    icon: FontAwesomeIcons.faceGrimace,
                    text: "lạnh buốt",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 9, 230, 0.7),
                    icon: FontAwesomeIcons.faceGrinBeamSweat,
                    text: "ngại ngùng",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(186, 9, 230, 0.89),
                    icon: FontAwesomeIcons.faceGrinSquint,
                    text: "thư giãn",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 178, 230, 0.832),
                    icon: FontAwesomeIcons.faceGrinSquintTears,
                    text: "vui sướng",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 9, 116, 0.845),
                    icon: FontAwesomeIcons.faceGrinBeam,
                    text: "vui vẻ",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 208, 9, 0.89),
                    icon: FontAwesomeIcons.faceKiss,
                    text: "thích thú",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 9, 20, 0.867),
                    icon: FontAwesomeIcons.faceKissWinkHeart,
                    text: "đáng yêu",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 230, 94, 0.833),
                    icon: FontAwesomeIcons.faceLaugh,
                    text: "sảng khoái",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 9, 204, 0.885),
                    icon: FontAwesomeIcons.faceGrinTongue,
                    text: "gợi đòn",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(122, 112, 42, 0.8),
                    icon: FontAwesomeIcons.faceSadCry,
                    text: "buồn sương sương",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 9, 230, 0.7),
                    icon: FontAwesomeIcons.faceSadTear,
                    text: "buồn rầu",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 178, 230, 0.832),
                    icon: FontAwesomeIcons.faceTired,
                    text: "mất hứng",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(186, 9, 230, 0.886),
                    icon: FontAwesomeIcons.faceMehBlank,
                    text: "im lặng",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 105, 230, 0.88),
                    icon: FontAwesomeIcons.faceMeh,
                    text: "bình thường",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 230, 90, 0.8),
                    icon: FontAwesomeIcons.faceRollingEyes,
                    text: "không biết gì",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 123, 9, 0.898),
                    icon: FontAwesomeIcons.faceSmile,
                    text: "khinh bỉ",
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(230, 230, 9, 0.9),
                    icon: FontAwesomeIcons.faceSmileBeam,
                    text: "vui vẻ",
                  ),
                  TableCellWidget(
                    height: 64,
                    color: Color.fromRGBO(9, 9, 230, 0.7),
                    icon: FontAwesomeIcons.faceGrinWide,
                    text: "ngây ngô",
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
