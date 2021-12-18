import 'package:flutter/material.dart';
import 'package:sit_volleyball_app/Pages/Setting/setting_page.dart';
import 'package:sit_volleyball_app/Pages/Video/video_page_after.dart';
import 'video/video_page.dart';
import 'Team/team_page.dart';

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
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _page[_selectedIndex]),
      bottomNavigationBar: _bottom(),
    );
  }

  Widget _bottom(){
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem> [
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
          label: 'setting'
        ),
      ],
    );
  }

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }
}
