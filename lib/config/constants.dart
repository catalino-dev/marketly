import 'package:flutter/material.dart';
import 'package:marketly/config/palette.dart';

const kPrimaryColor = Palette.primary;
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Palette.textColor;
const kGreenColor = Palette.primary;

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontFamily: 'Balsamiq',
  fontSize: 28,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);


const String DeleteCategory = 'Delete Category';
const List<String> contextMenu = <String>[
  DeleteCategory
];

const defaultDuration = Duration(milliseconds: 250);
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";

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
