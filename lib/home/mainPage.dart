import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gitpod/home/homepage.dart';
import 'package:gitpod/projects/projectspage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    ProjectsPage(),
    Container(),
    Container(),
    Container(),
    // Add more pages as needed
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      extendBody: true,
      floatingActionButton: GestureDetector(
        onTap: () {
          _onItemTapped(4);
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 142, 125, 255),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(100, 142, 125, 255),
                blurRadius: 30,
                spreadRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 35,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 70,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 20,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
              ),
              color: _currentIndex == 0
                  ? Color.fromARGB(255, 142, 125, 255)
                  : Colors.grey,
              onPressed: () {
                _onItemTapped(0);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.sticky_note_2,
              ),
              color: _currentIndex == 1
                  ? Color.fromARGB(255, 142, 125, 255)
                  : Colors.grey,
              onPressed: () {
                _onItemTapped(1);
              },
            ),
            SizedBox(width: 30),
            IconButton(
              icon: const Icon(
                Icons.email,
              ),
              color: _currentIndex == 2
                  ? Color.fromARGB(255, 142, 125, 255)
                  : Colors.grey,
              onPressed: () {
                _onItemTapped(2);
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
              ),
              color: _currentIndex == 3
                  ? Color.fromARGB(255, 142, 125, 255)
                  : Colors.grey,
              onPressed: () {
                _onItemTapped(3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
