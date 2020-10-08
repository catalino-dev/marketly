import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:marketly/main.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/list-header.dart';
import 'package:marketly/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Box<GroceryItems> cart;

  final TrackingScrollController _trackingScrollController = TrackingScrollController();
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Responsive(
          mobile:
          _HomeScreenMobile(scrollController: _trackingScrollController),
        ),
      ),
    );
  }
}

class _HomeScreenMobile extends StatelessWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: 60.0),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.segment,
                  size: 30.0,
                  color: Colors.grey,
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
          SizedBox(height: 20.0),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: FutureBuilder<Box<GroceryItems>>(
                  future: Hive.openBox(cartBoxName),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    }
                    int categorySize = snapshot.data != null ? snapshot.data.length : 0;
                    bool toCreateDefaultCategory = false;

                    if (categorySize == 0) {
                      categorySize = 1;
                      toCreateDefaultCategory = true;
                    }
                    print('---------------------------');
                    print(categorySize);

                    return GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        GroceryItems groceryItems;
                        if (toCreateDefaultCategory) {
                          groceryItems = GroceryItems(category: 'Default');
                        } else {
                          groceryItems = snapshot.data.get(index);
                        }
                        print('--------------');
                        print(groceryItems);

                        return CategoryCard(
                          category: groceryItems,
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => GroceryItemsScreen(groceryItems: groceryItems),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
              ),
            )
          ),
        ],
      ),
    );
  }
}
