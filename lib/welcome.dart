import 'package:flutter/material.dart';
import 'package:it4788/sign_in/sign_in.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(color: Color(0xffffffff)),
      child: Column(children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: Text("Chào mừng bạn đến với Anti-Facebook")),
        const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
            child:
                Text("Cùng trải nghiệm những điều mới mẻ với Anti-facebook")),
        const Padding(
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
                MaterialPageRoute(builder: (context) => SignIn()),
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignIn()),
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
