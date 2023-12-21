import 'dart:convert';

import 'package:it4788/service/auth.dart';

import 'package:it4788/sign_in/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:it4788/service/setting_service.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  Color currentPasswordIconColor = Colors.grey;
  Color newPasswordIconColor = Colors.grey;
  Color confirmPasswordIconColor = Colors.grey;
  bool _newPasswordVisible = false;
  bool _currentPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  void _logOut() async {
    final logOutResponse = await logOut();
    final jsonResponse = json.decode(logOutResponse.data);
    String message = jsonResponse['message'];

    if (message == 'OK') {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Đổi mật khẩu thành công'),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Đổi mật khẩu'),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Mật khẩu hiện tại',
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
                            obscureText: !_currentPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xFF1878F2)),
                              ),
                              hintText: 'Nhập mật khẩu hiện tại...',
                              suffixIcon: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  icon: Icon(
                                    _currentPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _currentPasswordVisible =
                                          !_currentPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            onChanged: (value) => {
                              setState(() {
                                currentPasswordIconColor = value.isEmpty
                                    ? Colors.grey
                                    : const Color(0xFF1878F2);
                              })
                            },
                            controller: _currentPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Đây là trường bắt buộc';
                              }
                              if (value.length < 6) {
                                return 'Mật khẩu phải có ít nhất 6 kí tự';
                              }

                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Mật khẩu mới',
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
                            obscureText: !_newPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xFF1878F2)),
                              ),
                              hintText: 'Nhập mật khẩu mới...',
                              suffixIcon: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  icon: Icon(
                                    _newPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _newPasswordVisible =
                                          !_newPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            onChanged: (value) => {
                              setState(() {
                                newPasswordIconColor = value.isEmpty
                                    ? Colors.grey
                                    : const Color(0xFF1878F2);
                              })
                            },
                            controller: _newPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Đây là trường bắt buộc';
                              }
                              if (value.length < 6) {
                                return 'Mật khẩu phải có ít nhất 6 kí tự';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Xác nhận mật khẩu',
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
                            obscureText: !_confirmPasswordVisible,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 16.0),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                borderSide: const BorderSide(
                                    width: 2, color: Color(0xFF1878F2)),
                              ),
                              hintText: 'Nhập mật khẩu mới...',
                              suffixIcon: Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: IconButton(
                                  icon: Icon(
                                    _confirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordVisible =
                                          !_confirmPasswordVisible;
                                    });
                                  },
                                ),
                              ),
                            ),
                            onChanged: (value) => {
                              setState(() {
                                confirmPasswordIconColor = value.isEmpty
                                    ? Colors.grey
                                    : const Color(0xFF1878F2);
                              })
                            },
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Đây là trường bắt buộc';
                              }
                              if (value.length < 6) {
                                return 'Mật khẩu phải có ít nhất 6 kí tự';
                              }
                              if (value != _newPasswordController.text) {
                                return 'Xác nhận mật khẩu không đúng';
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
                              String curPassword =
                                  _currentPasswordController.text;
                              String newPassword = _newPasswordController.text;
                              print("CURPASS $curPassword");
                              print("NEWPASS $newPassword");
                              final response = await SettingService()
                                  .changePassword(curPassword, newPassword);
                              // if (response.statusCode == 400) {
                              //   ScaffoldMessenger.of(context)
                              //       .showSnackBar(const SnackBar(
                              //     content: Text('Mật khẩu hiện tại không đúng'),
                              //   ));
                              //   return;
                              // }
                              final jsonResponse = json.decode(response.data);
                              String message = jsonResponse['message'];

                              if (message == 'OK') {
                                _logOut();
                                print("OKKKKKKKKKKKKKKKKKKKKKKK");
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1878F2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                          ),
                          child: const Text(
                            'Xác nhận',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ])),
        ));
  }
}
