import 'dart:ui';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class AppStyle {
  static TextStyle onBoardingTitleText = TextStyle(color: AppColors.mainColor, fontSize: 22, fontWeight: FontWeight.bold);
  static TextStyle headerTitleStyle = TextStyle(color: AppColors.blackColor, fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle headerTitleDesc = TextStyle(color: AppColors.mainColor, fontSize: 20);
  static TextStyle textStyleOne = TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold);
  static TextStyle textStyleTwo = TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  static TextStyle textStyle15 = TextStyle(color: AppColors.blackColor, fontSize: 15.sp, fontWeight: FontWeight.bold,fontFamily: "Cairo",);
  static TextStyle textStyle12 = TextStyle(color: AppColors.blackColor, fontSize: 12.sp, fontFamily: "CairoRegular",);
  static TextStyle textStyle10 = TextStyle(color: AppColors.mainColor, fontSize: 10.sp, fontFamily: "CairoRegular",);
}
