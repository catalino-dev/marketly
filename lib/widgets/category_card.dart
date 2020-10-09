import 'package:flutter/material.dart';
import 'package:marketly/config/constants.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/models/models.dart';

class CategoryCard extends StatelessWidget {
  final GroceryItems groceryItems;
  final int index;
  final Function press;

  const CategoryCard({
    Key key,
    this.groceryItems,
    this.index,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Palette.primary,
        ),
        child: groceryItems != null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                groceryItems.category,
                style: kTitleTextStyle.copyWith(color: Colors.white),
              ),
              SizedBox(height: 2.0),
              Text(
                '${groceryItems.items != null ? groceryItems.items.length : 0} Items',
                style: TextStyle(
                  color: Colors.white70.withOpacity(1),
                ),
              ),
            ]
        ) :
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Align(
            alignment: Alignment.center,
            child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.add,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Add category',
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ]
            ),
          ),
        ),
      ),
    );
  }
}
