import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Pages/User/user_page.dart';
import 'package:sit_volleyball_app/Pages/Video/video_page.dart';
import 'package:sit_volleyball_app/Pages/Team/team_page.dart';
import 'package:sit_volleyball_app/Pages/Setting/drawer_menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _page = const [
    VideoPage(),
    TeamPage(),
    UserPage(),
  ];

  void setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const DrawerMenu(),
      body: _page[_selectedIndex],
      bottomNavigationBar: _bottom(),
    );
  }

  Widget _bottom() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: setIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.video_collection),
          label: 'Video',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.paste),
          label: 'team',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'setting',
        ),
      ],
    );
  }
}
