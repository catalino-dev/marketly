import 'package:flutter/material.dart';
import 'package:marketly/screens/item_screen.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/bottom-bar.dart';
import 'package:marketly/widgets/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
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
        floatingActionButton: RawMaterialButton(
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.black,
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ItemScreen(),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
