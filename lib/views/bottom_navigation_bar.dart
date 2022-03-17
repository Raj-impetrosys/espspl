import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:espspl/views/homepage.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  List<Widget> screens = [
    Container(),
    const HomePage(),
    Container(),
  ];
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.notification_add),
          Icon(Icons.home),
          Icon(Icons.phone),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
