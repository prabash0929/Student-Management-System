import 'package:flutter/material.dart';

import 'create_student_page.dart';
import 'delete_student_page.dart';
import 'student_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    CreateStudentPage(),
    StudentListPage(),
    DeleteStudentPage(),
  ];

  static const List<String> _titles = <String>[
    'Create',
    'Read',
    'Delete',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          NavigationDestination(
            icon: Icon(Icons.list_alt),
            label: 'Read',
          ),
          NavigationDestination(
            icon: Icon(Icons.delete_outline),
            label: 'Delete',
          ),
        ],
      ),
    );
  }
}

