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
          child: Image.network(
              "data:image/png;base64,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",
              fit: BoxFit.cover),
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
            onPressed: () async {
              // await signUp("example1224đttrt@gmail.com", "Abcd1234", "ghfhf");
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
