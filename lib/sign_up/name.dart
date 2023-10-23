import 'package:flutter/material.dart';
import 'package:it4788/sign_up/birthday.dart';

class Name extends StatefulWidget {
  const Name();

  @override
  State<Name> createState() => _NameState();
}

class _NameState extends State<Name> {
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tên')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: const Text(
                'Bạn tên gì?',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        firstName = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Họ',
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Tên',
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
                        horizontal: 24.0), // Điều chỉnh giá trị padding tại đây
                  ),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterPage()));
              },
              child: const Text('Tiếp',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
