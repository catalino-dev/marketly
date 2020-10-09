import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';

import 'widgets.dart';

class CategoryGridList extends StatelessWidget {
  final String cartBoxName = 'cart';

  final Box<GroceryItems> cart;
  final Function press;

  const CategoryGridList({
    Key key,
    this.cart,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<Box<GroceryItems>>(
            future: Hive.openBox(cartBoxName),
            builder: (context, snapshot) {
              return ValueListenableBuilder(
                  valueListenable: cart.listenable(),
                  builder: (context, Box<GroceryItems> cart, _) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return CircularProgressIndicator();
                    }
                    int categorySize = snapshot.data != null ? snapshot.data.length : 0;
                    return GridView.builder(
                      padding: EdgeInsets.all(30),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: categorySize,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        GroceryItems groceryItems = snapshot.data.get(index);
                        int groceryIndex = index;
                        if (groceryItems == null) {
                          groceryIndex = null;
                        }

                        return CategoryCard(
                          groceryItems: groceryItems,
                          index: groceryIndex,
                          press: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => GroceryItemsScreen(groceryIndex: groceryIndex, groceryItems: groceryItems),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
              );
            }
        )
    );
  }
}
