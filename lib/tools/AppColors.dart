import 'package:flutter/material.dart';

class AppColors {
  static const Color errorColor = Colors.red;
  static const Color mainColor = Color(0xffF07824);
  static const Color locationColor = Color(0xffED512D);
  static const Color yellowColor = Color(0xffFFCC00);
  static const Color binkColor = Color(0xffFDF2EA);
  static const Color binkLiteColor = Color(0xffFFF8F3);
  static const Color binkLite2Color = Color(0xffFCE4D3);
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Color(0xff373636);
  static const Color grayColor = Color(0xffF8F8F8);
  static const Color grayLiteColor = Color(0xffBCC4CC);
  static const Color grayDarkColor = Color(0xffA6AAAC);
  static const Gradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.binkColor, Colors.white],
  );
  static List<BoxShadow> boxShadow= [
    BoxShadow(
      color: AppColors.grayColor,
      offset: const Offset(
        1.0,
        1.0,
      ),
      blurRadius: 1.0,
      spreadRadius: 2.0,
    ),
  ];

}
