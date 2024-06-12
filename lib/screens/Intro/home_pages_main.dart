import 'package:flutter/material.dart';
import 'package:travelapp/screens/blogs/blogs_list.dart';
import 'package:travelapp/screens/Creater/creater_screen_main.dart';
import 'package:travelapp/screens/Intro/home_screen.dart';
import 'package:travelapp/screens/Journey/all_journeys_screen.dart';
import 'package:travelapp/screens/User/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List _pages = [
    const HomeScreen(),
     MyJourneyScreen(),
    const CreaterScreen(),
     Blogslist(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(221, 0, 0, 0),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 2,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 35, 
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on_outlined,
              size: 35,
            ),
            label: 'Journeys',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              size: 35,
            ),
            label: 'Creater',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.library_books_outlined,
              size: 35,
            ),
            label: 'Blogs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_pin,
              size: 35,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
 
  void _onItemTapped(int index) {
    setState(() {
      
      if (index == 2) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return const CreaterScreen();
          },
        );
      }else{
        _selectedIndex = index;
      }
    });
  }
}
