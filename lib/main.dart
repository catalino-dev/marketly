import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:marketly/config/theme.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';
import 'package:path_provider/path_provider.dart';

const String cartBoxName = 'cart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

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
