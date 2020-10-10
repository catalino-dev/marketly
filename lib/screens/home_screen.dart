import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:marketly/config/constants.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/main.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/category_grid_list.dart';
import 'package:marketly/widgets/list-header.dart';
import 'package:marketly/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Box<GroceryItems> cart;

  @override
  void initState() {
    super.initState();
    cart = Hive.box<GroceryItems>(cartBoxName);
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 60),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Marketly',
                    style: kTitleTextStyle.copyWith(
                      color: Palette.primary,
                      fontSize: 24,
                      fontFamily: 'Balsamiq'
                    ),
                  ),
                  Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Text(
                'Shop on the go',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ListHeader(
              headerText: 'Categories',
              press: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => GroceryItemsScreen(),
                ),
              ),
            ),
            CategoryGridList(cart: cart),
          ],
        ),
      ),
    );
  }
}
