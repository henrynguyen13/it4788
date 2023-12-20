import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/reset_password.dart';

class VerifyResetPasswordPage extends StatefulWidget {
  const VerifyResetPasswordPage({super.key});

  @override
  State<VerifyResetPasswordPage> createState() =>
      _VerifyResetPasswordPageState();
}

class _VerifyResetPasswordPageState extends State<VerifyResetPasswordPage> {
  String email = "";
  String verifyCodeData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Xác nhận email')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: const Text(
                  'Hãy cho chúng tôi biết email của bạn',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30.0),
              TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal:
                              24.0), // Điều chỉnh giá trị padding tại đây
                    ),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () async {
                  final response = await emailIsExisted(email);

                  if (response == true) {
                    final verifyCodeResponse =
                        await _getVerifyCodeResponse(email);

                    if (verifyCodeResponse.statusCode == 200) {
                      try {
                        // Nếu không có lỗi, chuyển đổi nội dung JSON thành đối tượng Dart
                        final jsonResponse =
                            json.decode(verifyCodeResponse.data);

                        // Truy cập thuộc tính của đối tượng Dart
                        verifyCodeData = jsonResponse['data']['verify_code'];

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

                    if (!context.mounted) return;
                    if (response == true) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ResetPasswordPage(email: email)));
                    }
                  }
                },
                child: const Text('Xác nhận',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Response> _getVerifyCodeResponse(String email) async {
    final getVerifyCodeResponse = await getVerifyCode(email);
    return getVerifyCodeResponse;
  }

  void _sendVerifyCode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResetPasswordPage(email: email),
      ),
    );
  }
}
