import 'package:flutter/material.dart';
import 'package:tiktok_tutorial/constants.dart';
import 'package:tiktok_tutorial/views/screens/profile_screen.dart';
import 'package:tiktok_tutorial/views/screens/search_screen.dart';
import 'package:tiktok_tutorial/views/screens/video_screen.dart';

import 'add_video_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    VideoScreen(),
    SearchScreen(),
    AddVideoScreen(),
    ProfileScreen(uid: authController.user.uid)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.red[400],
        unselectedItemColor: Colors.black54,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, size: 30),
            activeIcon: Icon(Icons.home_rounded, size: 30),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined, size: 30),
            activeIcon: Icon(Icons.search_rounded, size: 30),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline_outlined, size: 30),
            activeIcon: Icon(Icons.add_circle_outlined, size: 30),
            label: 'Add Video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 30),
            activeIcon: Icon(Icons.person_rounded, size: 30),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
