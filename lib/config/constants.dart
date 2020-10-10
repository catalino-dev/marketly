import 'package:flutter/material.dart';
import 'package:marketly/config/palette.dart';

const kPrimaryColor = Palette.primary;
const kSecondaryColor = Palette.accent;
const kTextColor = Palette.textColor;

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const String EditCategoryName = 'Edit Category Name';
const String RemoveCategory = 'Remove Category';
const List<String> categoryContextMenu = <String>[
  EditCategoryName,
  RemoveCategory
];

const String RemoveItem = 'Remove Item';
const List<String> itemContextMenu = <String>[
  RemoveItem
];

const kTitleTextStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kHeadingStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 16,
  color: kTextColor,
);

final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: 15),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
