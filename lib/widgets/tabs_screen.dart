import 'package:flutter/material.dart';
import 'students_screen.dart';
import 'departments_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0; 

  final List<Map<String, dynamic>> _tabs = [
    {
      'screen': const DepartmentsScreen(),
      'title': 'Departments',
    },
    {
      'screen': const StudentsScreen(),
      'title': 'Students',
    },
  ];

  void _selectTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_selectedIndex]['title']),
      ),
      body: _tabs[_selectedIndex]['screen'],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Departments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Students',
          ),
        ],
      ),
    );
  }
}