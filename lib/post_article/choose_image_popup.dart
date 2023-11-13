import 'package:flutter/material.dart';

class ChooseImagePopup extends StatefulWidget {
  const ChooseImagePopup({super.key});

  @override
  State<ChooseImagePopup> createState() => _ChooseImagePopupState();
}

class _ChooseImagePopupState extends State<ChooseImagePopup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Open Bottom Sheet"),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => Center(
                      child: ElevatedButton(
                          child: Text("Close"),
                          onPressed: () => Navigator.pop(context)),
                    ));
          },
        ),
      ),
    );
  }
}
