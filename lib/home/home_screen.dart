import 'package:it4788/core/pallete.dart';
import 'package:it4788/home/add_friend_screen.dart';
import 'package:it4788/home/notice_screen.dart';
import 'package:it4788/home/post_screen.dart';
import 'package:it4788/home/search.dart';
import 'package:it4788/home/video_screen.dart';
import 'package:it4788/widgets/circle_button.dart';
import 'package:flutter/material.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Image(
            image: AssetImage(
              'assets/images/icons/anti-facebook.png',
            ),
          ),
        ),
        leadingWidth: 170,
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: CircleButton(
                icon: Icons.search,
                iconSize: 25.0,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ));
                }),
          ),
        ],
      ),
      body: PageView(controller: _pageController, children: const [
        PostScreen(key: PageStorageKey('postScreen')),
        AddFriendScreen(key: PageStorageKey('addFriendScreen')),
        VideoScreen(key: PageStorageKey('videoScreen')),
        NotificationScreen(key: PageStorageKey('notificationScreen')),
        MenuScreen(key: PageStorageKey('menuScreen')),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Allows more than 3 items
        currentIndex: _selectedIndex,
        selectedItemColor: Palette.facebookBlue,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);
        }, // Function to handle item taps
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Bạn bè',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video),
            label: 'Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Thông báo',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
            ),
            label: 'Tùy chọn',
          ),
        ],
      ),
    );
  }
}
