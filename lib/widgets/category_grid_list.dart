import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/screens/screens.dart';
import 'package:marketly/widgets/widgets.dart';

class CategoryGridList extends StatelessWidget {
  final String cartBoxName = 'cart';

  final Box<GroceryItems> cart;

  const CategoryGridList({
    Key key,
    this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(cart.values.length);
    if (cart.values.length == 0) {
      return EmptyState(
          actionText: 'Looks like there\'s nothing here!\nAdd new category',
          actionCommand: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => GroceryItemsScreen(),
              ),
            );
          }
      );
    }
    return Container(
        height: MediaQuery.of(context).size.height / 1.39,
        child: FutureBuilder<Box<GroceryItems>>(
            future: Hive.openBox(cartBoxName),
            builder: (context, snapshot) {

              return ValueListenableBuilder(
                  valueListenable: cart.listenable(),
                  builder: (context, Box<GroceryItems> cart, _) {

                    return GridView.builder(
                      padding: EdgeInsets.all(30),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: cart.values.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 0.75,
                      ),
                      itemBuilder: (context, index) {
                        GroceryItems groceryItems = cart.getAt(index);
                        int groceryIndex = index;
                        print(groceryItems);
                        print(groceryIndex);
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
