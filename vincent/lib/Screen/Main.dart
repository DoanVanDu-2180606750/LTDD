import 'package:flutter/material.dart';
import 'package:vincent/Screen/Explore.dart';
import 'package:vincent/Screen/Favorites.dart';
import 'package:vincent/Screen/Home.dart';
import 'package:vincent/Screen/Profile.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  static final _screen =<Widget> [
    HomeScreen(),
    ExploreScreen(),
    FavoritesScreen(),
    const ProfileScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {} ,
      //   child: Icon(Icons.chat, color: Colors.black, size: 30),
      // )
    );
  }
}