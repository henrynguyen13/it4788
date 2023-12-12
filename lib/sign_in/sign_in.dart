import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:it4788/service/auth.dart';
import 'package:it4788/sign_in/set_username.dart';
import 'package:it4788/sign_up/sign_up.dart';
import 'package:it4788/sign_up/verify_email.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Color emailIconColor = Colors.grey;
  Color passwordIconColor = Colors.grey;
  Color confirmPasswordIconColor = Colors.grey;
  bool _passwordVisible = true;

  String verifyCodeData = "";
  String emailData = "";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: const Color(0xfff1f1f1),
        body: SingleChildScrollView(
            // child: Form(
            //   key: formKey,
            //   child: Column(
            //     children: [
            //       Container(
            //         width: screenWidth,
            //         height: screenHeight * 0.35,
            //         color: Colors.blue[700],
            //         child: Icon(
            //           Icons.facebook_outlined,
            //           size: screenWidth * 0.2,
            //           color: Colors.white,
            //         ),
            //       ),
            //       Padding(
            //           padding: EdgeInsets.only(top: screenHeight * 0.03),
            //           child: const Text("Đăng nhập và tham gia cùng chúng tôi")),
            //       Padding(
            //           padding: EdgeInsets.only(top: screenHeight * 0.03),
            //           child: Column(
            //             children: [
            //               TextFormField(
            //                   validator: (value) {
            //                     if (value!.isEmpty) {
            //                       return "Chưa nhập địa chỉ email !";
            //                     }
            //                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
            //                         .hasMatch(value)) {
            //                       return "Nhập địa chỉ email sai định dạng !";
            //                     }
            //                   },
            //                   controller: _emailController,
            //                   decoration:
            //                       const InputDecoration(hintText: "Nhập email")),
            //               const Padding(padding: EdgeInsets.only(top: 20)),
            //               TextFormField(
            //                 validator: (value) {
            //                   if (value!.length < 6) {
            //                     return "Mật khẩu cần ít nhất 6 kí tự !";
            //                   }
            //                 },
            //                 obscureText: true,
            //                 obscuringCharacter: "*",
            //                 controller: _passwordController,
            //                 decoration:
            //                     const InputDecoration(hintText: "Nhập mật khẩu"),
            //               ),
            //               MaterialButton(
            //                 onPressed: () async {
            //                   if (formKey.currentState!.validate()) {
            //                     try {
            //                       String email = _emailController.text;
            //                       String password = _passwordController.text;

            //                       final response =
            //                           await signIn(email, password, 'uuid');

            //                       final jsonResponse = json.decode(response.data);
            //                       String message = jsonResponse['message'];
            //                       print(message);
            //                       if (message == 'OK') {
            //                         if (!context.mounted) return;
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) =>
            //                                   SetUsernamePage()),
            //                         );
            //                       }
            //                     } catch (e) {
            //                       print("Đăng nhập không thành công");
            //                     }
            //                   }
            //                 },
            //                 child: Container(
            //                   margin: const EdgeInsets.only(top: 20),
            //                   height: screenHeight * 0.06,
            //                   width: screenWidth,
            //                   color: Colors.blue[700],
            //                   alignment: Alignment.center,
            //                   child: const Text(
            //                     "Đăng nhập",
            //                     style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 18,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ),
            //               MaterialButton(
            //                 onPressed: () async {
            //                   String email = _emailController.text;
            //                   emailData = email;
            //                   final response =
            //                       await _getVerifyCodeResponse(email);

            //                   if (response.statusCode == 200) {
            //                     try {
            //                       // Nếu không có lỗi, chuyển đổi nội dung JSON thành đối tượng Dart
            //                       final jsonResponse = json.decode(response.data);

            //                       // Truy cập thuộc tính của đối tượng Dart
            //                       verifyCodeData =
            //                           jsonResponse['data']['verify_code'];

            //                       // In giá trị ra console
            //                       print("Verify Code: $verifyCodeData");

            //                       if (!context.mounted) return;
            //                       _sendVerifyCode(context);
            //                     } catch (e) {
            //                       print("Error parsing JSON: $e");
            //                     }
            //                   } else {
            //                     // Xử lý lỗi nếu có
            //                     print("Lỗi khi lấy verify code");
            //                   }
            //                 },
            //                 child: Padding(
            //                   padding: EdgeInsets.only(top: screenHeight * 0.03),
            //                   child: const Text(
            //                     "Quên mật khẩu?",
            //                     style: TextStyle(color: Colors.blue),
            //                   ),
            //                 ),
            //               ),
            //               Padding(
            //                   padding: EdgeInsets.only(top: screenHeight * 0.03),
            //                   child: const Row(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     children: [
            //                       Text("---------------------",
            //                           style: TextStyle(color: Colors.black)),
            //                       Text(" OR ",
            //                           style: TextStyle(color: Colors.black)),
            //                       Text("---------------------",
            //                           style: TextStyle(color: Colors.black)),
            //                     ],
            //                   )),
            //               MaterialButton(
            //                 onPressed: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => const SignUpPage()));
            //                 },
            //                 child: Container(
            //                   margin: const EdgeInsets.only(top: 20),
            //                   height: screenHeight * 0.06,
            //                   width: screenWidth,
            //                   color: Colors.green[700],
            //                   alignment: Alignment.center,
            //                   child: const Text(
            //                     "Tạo tài khoản mới",
            //                     style: TextStyle(
            //                         color: Colors.white,
            //                         fontSize: 18,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ))
            //     ],
            //   ),
            // ),
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
                              if (value.length < 6) {
                                return 'Mật khẩu phải có ít nhất 6 kí tự';
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
                                print(message);
                                if (message == 'OK') {
                                  if (!context.mounted) return;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SetUsernamePage()),
                                  );
                                }
                              } catch (e) {
                                print("Đăng nhập không thành công");
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
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 30),
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
                              MaterialPageRoute(builder: (context) => SignIn()),
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

  Future<Response> _getVerifyCodeResponse(String email) async {
    final getVerifyCodeResponse = await getVerifyCode(email);
    return getVerifyCodeResponse;
  }

  // get verify code to the VerifyEmailPage
  void _sendVerifyCode(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VerifyEmailPage(verifyCode: verifyCodeData, email: emailData),
      ),
    );
  }
}
