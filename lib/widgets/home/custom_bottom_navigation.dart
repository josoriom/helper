import 'package:flutter/material.dart';
import 'package:helper/themes/themes.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _index = 0;

  Map<int, String> directory = {
    0: 'home_screen',
    1: 'speech_screen',
    2: 'settings_screen'
  };

  void _onItemTap(int index) {
    setState(() {
      _index = index;
      print(directory[index] as String);
      Navigator.pushNamed(context, directory[index] as String);
    });
    // Navigator.pushNamed(context, directory[index]!);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: const Color.fromRGBO(31, 111, 140, 1),
      unselectedItemColor: const Color.fromRGBO(116, 117, 152, 1),
      backgroundColor: const Color(0xff202333),
      currentIndex: _index,
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle_outlined,
              size: 30,
            ),
            label: 'User'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.calendar_month,
              size: 30,
            ),
            label: 'Calendario'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 30,
            ),
            label: 'Settings'),
      ],
      onTap: _onItemTap,
    );
  }
}
