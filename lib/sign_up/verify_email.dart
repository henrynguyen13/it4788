// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/reset_password.dart';
import 'package:it4788/sign_in/sign_in.dart';

import '../sign_in/save_info.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key, required this.email});
  final String email;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  final TextEditingController _inputCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(57, 104, 214, 1),
            //color: Colors.black,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Back"),
                    ),
                  ),
                  Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    "Xác thực email",
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Text(
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              "Chúng tôi đã gửi mã xác thực tới email của bạn.",
            ),
          ),
          Text(
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              "Nhập mã xác thực gồm 6 chữ số:"),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  "FB-",
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: SizedBox(
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(57, 104, 214, 1),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _inputCodeController,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[500],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 300,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Color.fromRGBO(57, 104, 214, 1);
                    },
                  ),
                ),
                onPressed: () async {
                  final response = await checkVerifyCode(
                      widget.email, _inputCodeController.text);
                  final jsonResponse = json.decode(response.data);
                  String message = jsonResponse['message'];
                  if (message == 'OK') {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Xác thực thành công!'),
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Mã xác thực không chính xác!'),
                    ));
                  }
                },
                child: Text(
                  "Xác nhận",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          Divider(
            color: Color.fromARGB(68, 23, 23, 23),
            indent: 30,
            endIndent: 30,
          ),
          SizedBox(
            width: 300,
            height: 110,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      return Color.fromRGBO(192, 192, 192, 1);
                    },
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Gửi lại mã",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
