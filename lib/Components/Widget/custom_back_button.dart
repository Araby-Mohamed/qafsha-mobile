import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBackButton extends StatelessWidget {
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(context),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.blackColor,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        width: 33.w,
        height: 33.h,
        child: Icon(
          Icons.arrow_back_ios_sharp,
          color: Colors.white,
        ),
      ),
    );
  }

  CustomBackButton({this.onTap});
}
