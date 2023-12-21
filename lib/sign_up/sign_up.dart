import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/sign_in.dart';
import 'package:it4788/sign_up/verify_email.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Color emailIconColor = Colors.grey;
  Color passwordIconColor = Colors.grey;
  Color confirmPasswordIconColor = Colors.grey;
  bool _passwordVisible = false;

  String verifyCodeData = "";
  String emailData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Image(
              image: AssetImage('assets/images/auth_facebook.png'),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: SizedBox(
                  child: TextFormField(
                    decoration: InputDecoration(
                      // contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFF1878F2)),
                      ),
                      hintText: 'Nhập địa chỉ email...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.email,
                          color: emailIconColor,
                        ),
                      ),
                    ),
                    onChanged: (value) => {
                      setState(() {
                        emailIconColor = value.isEmpty
                            ? Colors.grey
                            : const Color(0xFF1878F2);
                      })
                    },
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Đây là trường bắt buộc';
                      }
                      return EmailValidator.validate(value)
                          ? null
                          : "Vui lòng nhập đúng định dạng email";
                    },
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Mật khẩu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: SizedBox(
                  child: TextFormField(
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(
                            width: 2, color: Color(0xFF1878F2)),
                      ),
                      hintText: 'Nhập mật khẩu...',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.lock,
                          color: passwordIconColor,
                        ),
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    onChanged: (value) => {
                      setState(() {
                        passwordIconColor = value.isEmpty
                            ? Colors.grey
                            : const Color(0xFF1878F2);
                      })
                    },
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Đây là trường bắt buộc';
                      }
                      if (value.length < 6 || value.length > 10) {
                        return 'Mật khẩu phải có từ 6 đến 10 kí tự';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      emailData = email;

                      final checkEmailResponse = await emailIsExisted(email);
                      if (checkEmailResponse == true) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Email đã tồn tại tài khoản!'),
                        ));
                      } else {
                        final signUpResponse =
                            await signUp(email, password, 'uuid');

                        final jsonResponse = json.decode(signUpResponse.data);
                        String message = jsonResponse['message'];

                        if (message == 'OK') {
                          final getVerifyCodeResponse =
                              await _getVerifyCodeResponse(email);

                          if (getVerifyCodeResponse.statusCode == 200) {
                            try {
                              // Nếu không có lỗi, chuyển đổi nội dung JSON thành đối tượng Dart
                              final jsonResponse =
                                  json.decode(getVerifyCodeResponse.data);

                              // Truy cập thuộc tính của đối tượng Dart
                              verifyCodeData =
                                  jsonResponse['data']['verify_code'];

                              // In giá trị ra console
                              print("Verify Code: $verifyCodeData");

                              if (!context.mounted) return;
                              _sendVerifyCode(context);
                            } catch (e) {
                              print("Error parsing JSON: $e");
                            }
                          } else {
                            // Xử lý lỗi nếu có
                            print("Lỗi khi lấy verify code");
                          }
                        }
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1878F2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Đăng ký',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'BẠN ĐÃ CÓ TÀI KHOẢN ?',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Divider(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF31A24C),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Đăng nhập',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ])),
    ));
  }

  Future<Response> _getVerifyCodeResponse(String email) async {
    final getVerifyCodeResponse = await getVerifyCode(email);
    return getVerifyCodeResponse;
  }

  // get verify code to the VerifyEmailPage
  void _sendVerifyCode(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Gửi mã xác thực thành công!'),
    ));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerifyEmailPage(email: emailData),
      ),
    );
  }
}
