import 'package:flutter/material.dart';
import 'package:studyplanner/constants/colors.dart';
import 'package:studyplanner/pages/mainscreens/assignments_page.dart';
import 'package:studyplanner/pages/mainscreens/courses_page.dart';
import 'package:studyplanner/pages/mainscreens/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [HomePage(), CoursesPage(), AssignmentsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Courses"),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: "Assignments",
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _pages[_selectedIndex],
    );
  }
}
