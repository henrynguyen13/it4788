import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/pallete.dart';

class MenuItem extends StatefulWidget {
  final IconData icon;
  final String text;
  final Function function;

  const MenuItem({
    required this.icon,
    required this.text,
    required this.function, // This should be a function.
    Key? key, // Use "Key?" instead of "super.key".
  }) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          widget.function(); // Call the function using parentheses.
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(widget.icon, color: Palette.facebookBlue, size: 40.0,),
              const SizedBox(width: 15.0,),
              Text(widget.text),
            ],
          ),
        ),
      ),
    );
  }
}
