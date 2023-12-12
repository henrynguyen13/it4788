// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:it4788/data_storage/authStorage.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/reset_password.dart';

import '../sign_in/save_info.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage(
      {super.key, required this.verifyCode, required this.email});

  final String verifyCode;
  final String email;

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
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
                        child: Text(
                          widget.verifyCode,
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
                  await checkVerifyCode(widget.email, widget.verifyCode);

                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswordPage()),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => SaveInfoPage(
                  //             title: '',
                  //           )),
                  // );
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
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          //       (Set<MaterialState> states) {
          //         return const Color.fromARGB(0, 255, 255, 255);
          //       },
          //     ),
          //     shadowColor: MaterialStateProperty.resolveWith<Color?>(
          //       (Set<MaterialState> states) {
          //         return Colors.transparent;
          //       },
          //     ),
          //   ),
          //   onPressed: () {},
          //   child: Text(
          //     "Đăng xuất",
          //     style: TextStyle(
          //       color: Color.fromRGBO(57, 104, 214, 1),
          //       fontSize: 16,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
