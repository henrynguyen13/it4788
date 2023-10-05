// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../sign_in/save_info.dart';

class VeryfyEmailPage extends StatefulWidget {
  const VeryfyEmailPage({super.key, required this.title});

  final String title;

  @override
  State<VeryfyEmailPage> createState() => _VeryfyEmailPageState();
}

class _VeryfyEmailPageState extends State<VeryfyEmailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Container(
            color: Color.fromRGBO(57, 104, 214, 1),
            //color: Colors.black,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 30, 0, 0),
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
              "Nhập mã xác thực gồm 5 chữ số:"),
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
                    child: TextFormField(
                      autofocus: false,
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(57, 104, 214, 1),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(8),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SaveInfoPage(
                              title: '',
                            )),
                  );
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
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return const Color.fromARGB(0, 255, 255, 255);
                },
              ),
              shadowColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  return Colors.transparent;
                },
              ),
            ),
            onPressed: () {},
            child: Text(
              "Đăng xuất",
              style: TextStyle(
                color: Color.fromRGBO(57, 104, 214, 1),
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
