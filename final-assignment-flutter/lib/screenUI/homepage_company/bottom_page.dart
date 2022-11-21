import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:hirexapp/screenUI/homepage_company/add_job.dart';
import 'package:hirexapp/screenUI/homepage_company/applicants.dart';
import 'package:hirexapp/screenUI/homepage_company/view_jobs.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const AddJob(),
    const MyJobs(),
    const Applicants()
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
          TabItem(title: 'Add jobs', icon: Icons.add),
          TabItem(title: 'my jobs', icon: Icons.view_agenda),
          TabItem(icon: Icons.person, title: 'Applicants'),
        ],
        onTap: _onItemTapped,
        color: Colors.white,
      ),
    );
  }
}
