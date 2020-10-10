import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marketly/config/theme.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';

const String cartBoxName = 'cart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(GroceryItemsAdapter());
  Hive.registerAdapter(ItemAdapter());
  await Hive.openBox<GroceryItems>(cartBoxName);

  runApp(MarketlyApp());
}

class MarketlyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketly',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      home: HomeScreen(),
    );
  }
}
