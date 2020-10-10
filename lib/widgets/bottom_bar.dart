import 'package:flutter/cupertino.dart';
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
        borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
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
