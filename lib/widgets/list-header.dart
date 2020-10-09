import 'package:flutter/material.dart';
import 'package:marketly/config/constants.dart';

class ListHeader extends StatelessWidget {

  final String headerText;
  final Function press;

  const ListHeader({
    Key key,
    this.headerText,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
              headerText,
              style: kTitleTextStyle
          ),
          IconButton(
            icon: Icon(Icons.add, color: Colors.black38),
            onPressed: press,
          ),
        ],
      ),
    );
  }
}
