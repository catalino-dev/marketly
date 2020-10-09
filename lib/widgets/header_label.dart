import 'package:flutter/material.dart';

class HeaderLabel extends StatelessWidget {
  const HeaderLabel({
    Key key,
    @required this.labelText,
  }) : super(key: key);

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5),
      color: Colors.grey.withOpacity(0.1),
      child: Text(
        labelText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
