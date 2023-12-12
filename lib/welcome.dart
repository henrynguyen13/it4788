import 'package:flutter/material.dart';
import 'package:it4788/service/api_service.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/sign_in.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Color(0xffffffff)),
      child: Column(children: [
        Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Text("Chào mừng đến với Anti-Facebook")),
        Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
            child: Text(
                "Chúng tôi hi vọng bạn sẽ có những trải nghiệm tuyệt vời với Anti-facebook")),
        Padding(
          padding: EdgeInsets.all(32),
          child: Image(
            image: AssetImage('assets/images/icons/fb_icon.png'),
            width: 100,
            height: 100,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(48, 32, 48, 32),
          child: MaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            color: Color.fromARGB(255, 7, 101, 194),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22.0),
              side: BorderSide(color: Color(0xff3a57e8), width: 1),
            ),
            padding: EdgeInsets.all(8),
            child: Text(
              "Đăng nhập",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
            textColor: Color.fromARGB(255, 235, 235, 238),
            height: 45,
            minWidth: MediaQuery.of(context).size.width,
          ),
        ),
        Text("Chưa có tài khoản ?"),
        Padding(
          padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
          child: TextButton(
            onPressed: () async {
              // await signUp("example1224đttrt@gmail.com", "Abcd1234", "ghfhf");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
            child: const Text(
              "Đăng ký",
              style: TextStyle(
                color: Color.fromARGB(255, 24, 39, 208),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.normal,
              ),
            ),
          ),
        ),
      ]),
    ));
  }
}
