import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marketly/category/category.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/item/item_model.dart';
import 'package:marketly/screens/screens.dart';
import 'package:path_provider/path_provider.dart';

const String categoryBoxName = 'categories';
const String cartBoxName = 'cart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.openBox<Category>(categoryBoxName);
  Hive.openBox<Item>(cartBoxName);
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
