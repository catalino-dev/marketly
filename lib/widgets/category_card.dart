import 'package:flutter/material.dart';
import 'package:marketly/config/palette.dart';
import 'package:marketly/models/models.dart';

class CategoryCard extends StatelessWidget {
  final GroceryItems category;
  final Function press;

  const CategoryCard({
    Key key,
    this.category,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        height: 125.0,
        width: 225.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: Palette.primary
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Text(
                category.category,
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ]
        ),
      ),
    );
  }
}
