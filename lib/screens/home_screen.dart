import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:marketly/category/category.dart';
import 'package:marketly/item/item.dart';
import 'package:marketly/main.dart';
import 'package:marketly/screens/category_items_screen.dart';
import 'package:marketly/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  final String cartBoxName = 'cart';

  Box<Category> categories;
  Box<Item> cart;

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Categories",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add, color: Colors.black26),
                  onPressed: null,
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: FutureBuilder<Box<Category>>(
                future: Hive.openBox(categoriesBoxName),
                builder: (context, snapshot) {
                  int defaultValueCount = snapshot.data.length;
                  bool toCreateDefaultCategory = false;
                  print(snapshot.data);

                  if (defaultValueCount == 0) {
                    defaultValueCount = 1;
                    toCreateDefaultCategory = true;
                  }

                  return ListView.builder(
                    itemCount: defaultValueCount,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      Category category;
                      if (toCreateDefaultCategory) {
                        category = Category(name: 'Default');
                      } else {
                        category = snapshot.data.get(index);
                      }

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CategoryItemsScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 200,
                          margin: EdgeInsets.only(right: 16),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: _buildBackground(category, 230),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
            ),
          ),
          SizedBox(height: 20.0),
          // Container(
          //   height: 400.0,
          //   width: double.infinity,
          //   child: PageView.builder(
          //     controller: pageController,
          //     onPageChanged: (int index) {
          //     },
          //     itemCount: 2,
          //     itemBuilder: (BuildContext context, int index) {
          //       return _itemSelector(context, index);
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildBackground(Category category, double width) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 20.0),
      height: 120.0,
      width: 225.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Color(0xFFDAB68C)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.0),
          Text(
            category.name,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ]
      ),
    );
  }
}
