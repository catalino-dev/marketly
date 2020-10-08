import 'package:flutter/material.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/widgets.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen()
  ];
  final List<IconData> _icons = const [
    Icons.home
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
          preferredSize: Size(screenSize.width, 100.0),
          child: CustomAppBar(
            icons: _icons,
            selectedIndex: _selectedIndex,
            onTap: (index) => setState(() => _selectedIndex = index),
          ),
        )
            : null,
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
      ),
    );
  }
}
