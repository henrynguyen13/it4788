// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '/flutter_flow_animations.dart';

class SaveInfoPage extends StatefulWidget {
  const SaveInfoPage({super.key, required this.title});

  final String title;

  @override
  State<SaveInfoPage> createState() => _SaveInfoPageState();
}

class _SaveInfoPageState extends State<SaveInfoPage> {
  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      curve: Curves.easeInOut,
      delay: 0,
      duration: 600,
      initialState: AnimationState(offset: Offset(0, 1000)),
      finalState: AnimationState(offset: Offset(0, 0)),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(80),
          child: Image(
            image: AssetImage('assets/images/icons/fb_icon.png'),
            width: 80,
            height: 80,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Container(
            child: Column(children: [
              savedInfoUser(
                  "assets/images/icons/avatar_icon.png", "Hoang Pham"),
              savedInfoUser("assets/images/icons/avatar_icon.png", "Hieu Ngu"),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 180, 0, 50),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          )),
                    ),
                    child: Text(
                      "Lúc khác",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(125, 0, 0, 0),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                          side: BorderSide(
                            color: Colors.transparent,
                            width: 0,
                          )),
                    ),
                    child: Text(
                      "OK",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(57, 104, 214, 1),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ).animate().moveY(
            delay: Duration(seconds: 0),
            duration: Duration(milliseconds: 500),
            begin: 1000,
            end: 0));
  }

  Padding savedInfoUser(String avatarPath, String username) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: SizedBox(
        width: 350,
        height: 80,
        child: ElevatedButton(
            onPressed: () {},
            child: Row(
              children: [
                Image(
                  image: AssetImage(avatarPath),
                  width: 80,
                  height: 80,
                ),
                Text(
                  username,
                  style: TextStyle(
                      fontSize: 22, color: Color.fromRGBO(57, 104, 214, 1)),
                ),
              ],
            )),
      ),
    );
  }
}
