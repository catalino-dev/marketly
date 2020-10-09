import 'package:flutter/material.dart';
import 'package:marketly/config/constants.dart';

class ItemContent extends StatelessWidget {
  final String number;
  final String name;
  final String description;
  final bool isDone;

  const ItemContent({
    Key key,
    this.number,
    this.name,
    this.description,
    this.isDone = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: <Widget>[
          Text(
            number,
            style: kHeadingStyle.copyWith(
              color: kTextColor.withOpacity(.15),
              fontSize: 32,
            ),
          ),
          SizedBox(width: 20),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: name,
                  style: kSubtitleTextStyle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: description,
                  style: TextStyle(
                    color: kTextColor.withOpacity(.5),
                    fontSize: 14,
                    height: 1.8,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(left: 20),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kGreenColor.withOpacity(isDone ? 1 : .5),
            ),
            child: Icon(Icons.chevron_right_rounded, color: Colors.white),
          )
        ],
      ),
    );
  }
}
