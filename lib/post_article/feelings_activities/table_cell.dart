import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TableCellWidget extends StatelessWidget {
  final double height;
  final Color color;
  final IconData icon;
  final String text;

  const TableCellWidget({
    super.key,
    required this.height,
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.top,
      child: Container(
        height: height,
        color: Colors.white,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                print("Pressed");
              },
              color: color,
              icon: FaIcon(icon),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
