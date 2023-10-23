import 'package:flutter/material.dart';
import 'package:it4788/sign_up/account.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String selectedDay = '1';
  String selectedMonth = 'January';
  String selectedYear = '1920';
  String errorText = '';
  final List<String> days =
      List.generate(31, (index) => (index + 1).toString());
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
  final List<String> years =
      List.generate(98, (index) => (1920 + index).toString());

  bool isValidDay(String day, String month) {
    int? selectedDayInt = int.tryParse(day) ?? 1;
    int selectedMonthIndex = months.indexOf(month) + 1;

    if (selectedMonthIndex == 2) {
      if (int.tryParse(selectedYear)! % 4 == 0) {
        return selectedDayInt <= 29;
      } else {
        return selectedDayInt <= 28;
      }
    } else if ([4, 6, 9, 11].contains(selectedMonthIndex)) {
      return selectedDayInt <= 30;
    } else {
      return selectedDayInt <= 31;
    }
  }

  void validateDate() {
    if (!isValidDay(selectedDay, selectedMonth)) {
      setState(() {
        errorText = 'Có vẻ như bạn nhập sai';
      });
    } else {
      setState(() {
        errorText = '';
      });
      // Xử lý logic khi ngày tháng hợp lệ
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          'Ngày sinh',
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.right, // Add the `textAlign` parameter
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text(
                'Sinh nhật của bạn là khi nào ?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold, // Làm đậm
                ),
                textAlign: TextAlign.center, // Căn giữa
              ),
            ),
            SizedBox(height: 30.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: <Widget>[
                  DropdownButton<String>(
                    value: selectedDay,
                    onChanged: (String? newValue) {
                      if (isValidDay(newValue!, selectedMonth)) {
                        setState(() {
                          selectedDay = newValue;
                        });
                      }
                    },
                    items: days.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 20.0),
                  DropdownButton<String>(
                    value: selectedMonth,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMonth = newValue!;
                      });
                    },
                    items: months.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(width: 32.0),
                  DropdownButton<String>(
                    value: selectedYear,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                    items: years.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.0),
            // Hiển thị thông báo lỗi
            Text(
              errorText,
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 32.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Account()),
                );
              },
              child: Text('Đăng ký'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
