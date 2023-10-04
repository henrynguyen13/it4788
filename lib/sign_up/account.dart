import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Tài khoản';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 24.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          title: const Text(
            appTitle,
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  Color emailIconColor = Colors.grey;
  Color passwordIconColor = Colors.grey;
  Color confirmPasswordIconColor = Colors.grey;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Địa chỉ email',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xFF1C58C9)),
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
                    emailIconColor =
                        value.isEmpty ? Colors.grey : const Color(0xFF1C58C9);
                  })
                },
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
            const Text(
              'Mật khẩu',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12.0,
              ),
              child: TextFormField(
                obscureText: !_passwordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xFF1C58C9)),
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
                    passwordIconColor =
                        value.isEmpty ? Colors.grey : const Color(0xFF1C58C9);
                  })
                },
                controller: _pass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Đây là trường bắt buộc';
                  }
                  return null;
                },
              ),
            ),
            const Text(
              'Xác nhận mật khẩu',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 12,
              ),
              child: TextFormField(
                obscureText: !_confirmPasswordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 2, color: Color(0xFF1C58C9)),
                  ),
                  hintText: 'Nhập mật khẩu...',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(
                      Icons.lock,
                      color: confirmPasswordIconColor,
                    ),
                  ),
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
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                onChanged: (value) => {
                  setState(() {
                    confirmPasswordIconColor =
                        value.isEmpty ? Colors.grey : const Color(0xFF1C58C9);
                  })
                },
                controller: _confirmPass,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Đây là trường bắt buộc';
                  }
                  if (value != _pass.text) return 'Mật khẩu không khớp';
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C58C9),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Tiếp tục'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
