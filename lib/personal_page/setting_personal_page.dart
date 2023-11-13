import 'package:flutter/material.dart';
import 'package:it4788/personal_page/edit_personal_page.dart';
import 'package:it4788/personal_page/search_personal_page.dart';

class SettingPersonalPage extends StatefulWidget {
  const SettingPersonalPage({super.key});

  @override
  State<SettingPersonalPage> createState() => _SettingPersonalPageState();
}

class _SettingPersonalPageState extends State<SettingPersonalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt trang cá nhân'),
      ),
      body: Column(children: [
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EditPersonalPage()),
                )
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.edit,
                    color: Colors.black45,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Chỉnh sửa trang cá nhân',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchPersonalPage()),
                )
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black45,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'Tìm kiếm trên trang cá nhan',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
