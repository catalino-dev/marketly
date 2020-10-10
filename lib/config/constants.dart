import 'package:flutter/material.dart';
import 'package:marketly/config/palette.dart';

const kPrimaryColor = Palette.primary;
const kSecondaryColor = Palette.accent;
const kTextColor = Palette.textColor;

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

const kHeadingStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 28,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kTitleTextStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 20,
  color: kTextColor,
  fontWeight: FontWeight.bold,
);

const kSubtitleTextStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 16,
  color: kTextColor,
);

final inputDecoration = InputDecoration(
  floatingLabelBehavior: FloatingLabelBehavior.always,
  contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: Colors.black38),
    gapPadding: 10,
  );
}

OutlineInputBorder outlineInputBorderDark() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: Colors.white70),
    gapPadding: 10,
  );
}
