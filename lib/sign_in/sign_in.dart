import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:it4788/home.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  bool toggleVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: const Color(0xfff1f1f1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.25,
                  decoration: BoxDecoration(
                    color: const Color(0xff3a57e8),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80.0),
                        bottomRight: Radius.circular(80.0)),
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRviAGWGV45QGRAHOv3Hh35VxwyNU_Qiy8ZK_8PytS-eTrEMY4RgaNgInAQie6VgqvSA24&usqp=CAU",
                            fit: BoxFit.cover),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Text(
                          "Đăng nhập ngay",
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(16, 48, 16, 48),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Chưa nhập địa chỉ email !";
                                  }
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                      .hasMatch(value)) {
                                    return "Nhập địa chỉ email sai định dạng !";
                                  }
                                },
                                controller: TextEditingController(),
                                obscureText: false,
                                textAlign: TextAlign.start,
                                textAlignVertical: TextAlignVertical.center,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14,
                                  color: Color(0xff000000),
                                ),
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    borderSide: BorderSide(
                                        color: Color(0xffffffff), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    borderSide: BorderSide(
                                        color: Color(0xffffffff), width: 1),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(22.0),
                                    borderSide: BorderSide(
                                        color: Color(0xffffffff), width: 1),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                  filled: true,
                                  fillColor: Color(0xffffffff),
                                  isDense: false,
                                  contentPadding: EdgeInsets.all(8),
                                  prefixIcon: Icon(Icons.mail,
                                      color: Color.fromARGB(255, 92, 89, 89),
                                      size: 20),
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.length < 6) {
                                      return "Mật khẩu cần ít nhất 6 kí tự !";
                                    }
                                  },
                                  controller: TextEditingController(),
                                  obscureText: !toggleVisiblePassword,
                                  textAlign: TextAlign.start,
                                  textAlignVertical: TextAlignVertical.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14,
                                    color: Color(0xff000000),
                                  ),
                                  decoration: InputDecoration(
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                      borderSide: BorderSide(
                                          color: Color(0xffffffff), width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                      borderSide: BorderSide(
                                          color: Color(0xffffffff), width: 1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22.0),
                                      borderSide: BorderSide(
                                          color: Color(0xffffffff), width: 1),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14,
                                      color: Color(0xff000000),
                                    ),
                                    filled: true,
                                    fillColor: Color(0xffffffff),
                                    contentPadding: EdgeInsets.all(8),
                                    isDense: false,
                                    prefixIcon: Icon(Icons.lock,
                                        color: Color.fromARGB(255, 92, 89, 89),
                                        size: 20),
                                    suffix: IconButton(
                                      iconSize: 20,
                                      icon: !toggleVisiblePassword
                                          ? Icon(
                                              Icons.visibility_off,
                                              color: Color.fromARGB(
                                                  255, 92, 89, 89),
                                            )
                                          : Icon(Icons.visibility,
                                              color: Color.fromARGB(
                                                  255, 92, 89, 89)),
                                      onPressed: () => {
                                        setState(() {
                                          toggleVisiblePassword =
                                              !toggleVisiblePassword;
                                        }),
                                      },
                                    ),
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password?",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontStyle: FontStyle.normal,
                                      fontSize: 12,
                                      color: Color(0xff3a57e8),
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    print("Đăng nhập thành công !");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                    );
                                  } else {
                                    print("Đăng nhập thất bại !");
                                  }
                                },
                                color: Color(0xff3a57e8),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                  side: BorderSide(
                                      color: Color(0xff3a57e8), width: 1),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "Đăng nhập",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                textColor: Color(0xffffffff),
                                height: 45,
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Chưa có tài khoản ?",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CupertinoButton(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                child: Text(
                  "Đăng ký tại đây",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                    color: Color(0xff3a57e8),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              })
        ],
      ),
    );
  }
}
