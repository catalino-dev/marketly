import 'package:flutter/material.dart';
import 'package:marketly/models/models.dart';
import 'package:marketly/widgets/widgets.dart';

class GroceryListContainer extends StatelessWidget {
  final Grocery grocery;

  const GroceryListContainer({
    Key key,
    @required this.grocery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _GroceryHeader(grocery: grocery),
                  const SizedBox(height: 4.0),
                  Text(grocery.description),
                  const SizedBox(height: 6.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroceryHeader extends StatelessWidget {
  final Grocery grocery;

  const _GroceryHeader({
    Key key,
    @required this.grocery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          grocery.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}
