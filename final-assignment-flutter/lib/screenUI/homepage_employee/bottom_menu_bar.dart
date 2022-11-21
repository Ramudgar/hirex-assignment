import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hirexapp/screenUI/Pages/emp_profile.dart';
import 'package:hirexapp/screenUI/homepage_employee/emp_setting.dart';
import 'package:hirexapp/screenUI/homepage_employee/homes_screen.dart';

class BottomMenuBar extends StatefulWidget {
  const BottomMenuBar({Key? key}) : super(key: key);

  @override
  State<BottomMenuBar> createState() => _BottomMenuBarState();
}

class _BottomMenuBarState extends State<BottomMenuBar> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const EmpSetting(),
    const EmpProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        // backgroundColor: Colors.blueAccent,
        items: const [
          TabItem(title: 'Home', icon: Icons.home_outlined),
          TabItem(title: 'my Applications', icon: Icons.view_agenda),
          TabItem(icon: Icons.person, title: 'profile'),
        ],
        onTap: _onItemTapped,
        color: Colors.white,
      ),
    );
  }
}
