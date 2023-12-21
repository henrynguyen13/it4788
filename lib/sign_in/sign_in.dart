import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it4788/home/home_screen.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/reset_password.dart';
import 'package:it4788/sign_in/set_username.dart';
import 'package:it4788/sign_in/verify_reset_password.dart';
import 'package:it4788/sign_up/sign_up.dart';
import 'package:it4788/sign_up/verify_email.dart';
import 'package:it4788/firebase_api/firebase_api.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignIn();
}

class _SignIn extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Color emailIconColor = Colors.grey;
  Color passwordIconColor = Colors.grey;
  Color confirmPasswordIconColor = Colors.grey;
  bool _passwordVisible = false;

  String verifyCodeData = "";
  String emailData = "";

  void setDevToken() async {
    FirebaseApi().setDevTokenFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff1f1f1),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                              if (value!.isEmpty) {
                                return "Chưa nhập địa chỉ email !";
                              }
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                                return "Nhập địa chỉ email sai định dạng !";
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Mật khẩu',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                String email = _emailController.text;
                                String password = _passwordController.text;

                                final response =
                                    await signIn(email, password, 'uuid');

                                final jsonResponse = json.decode(response.data);
                                String message = jsonResponse['message'];
                                String username =
                                    jsonResponse['data']['username'];

                                if (message == 'OK' && username != '') {
                                  if (!context.mounted) return;
                                  setDevToken();
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (Route<dynamic> route) => false,
                                  );
                                } else {
                                  if (!context.mounted) return;
                                  setDevToken();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SetUsernamePage()));
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Đăng nhập không thành công!')));
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
                            'Đăng nhập',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        onPressed: () {
                          _navigateToVerifyResetPasswordPage(context);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            "Quên mật khẩu?",
                            style: TextStyle(color: Color(0xFF1878F2)),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'TẠO TÀI KHOẢN MỚI ?',
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()),
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
                            'Đăng ký',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }

  void _navigateToVerifyResetPasswordPage(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const VerifyResetPasswordPage()));
  }
}
