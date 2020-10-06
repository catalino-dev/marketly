import 'package:flutter/material.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/screens/screens.dart';

void main() {
  runApp(MarketlyApp());
}

class MarketlyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Palette.scaffold,
      ),
      home: NavScreen(),
    );
  }
}
