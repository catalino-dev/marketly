import 'package:flutter/material.dart';
import 'package:marketly/config/constants.dart';
import 'package:marketly/config/palette.dart';

class BottomBar extends StatelessWidget {
  final String buttonText;
  final Function buttonAction;

  const BottomBar({
    Key key,
    this.buttonText,
    this.buttonAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 50,
            color: kTextColor.withOpacity(.1),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(14),
            height: 48,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.3),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Icon(
              Icons.remove_shopping_cart,
              size: 24.0,
              color: Palette.textColor,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: GestureDetector(
              onTap: buttonAction,
              child: Container(
                alignment: Alignment.center,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Palette.primary,
                ),
                child: Text(
                  buttonText,
                  style: kSubtitleTextStyle.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
