import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it4788/post_article/post_article.dart';

class TableCellWidget extends StatefulWidget {
  const TableCellWidget({
    super.key,
    required this.height,
    required this.color,
    required this.icon,
    required this.feelingState,
  });

  final double height;
  final Color color;
  final IconData icon;
  final String feelingState;

  @override
  State<TableCellWidget> createState() => _TableCellWidgetState();
}

class _TableCellWidgetState extends State<TableCellWidget> {
  bool isFeelingSelected = false;

  @override
  Widget build(BuildContext context) {
    return TableCell(
        verticalAlignment: TableCellVerticalAlignment.top,
        child: InkWell(
          onTap: () {
            setState(() {
              isFeelingSelected = true;
            });

            _sendFeelingBack(context);
          },
          child: Container(
            height: widget.height,
            color: isFeelingSelected ? Colors.grey[100] : Colors.white,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  color: widget.color,
                  icon: FaIcon(widget.icon),
                ),
                Text(widget.feelingState),
              ],
            ),
          ),
        ));
  }

  void _sendFeelingBack(BuildContext context) {
    String feelingToSendBack = widget.feelingState;
    Navigator.pop(context, feelingToSendBack);
  }
}
