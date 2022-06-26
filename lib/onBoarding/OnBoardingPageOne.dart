import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingBody extends StatelessWidget {
  final String title, mess, imagePath;
  OnBoardingBody(
      {@required this.title, @required this.mess, @required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    Resources.ON_BOARDING_BACKGROUND,
                    color: AppColors.binkColor,
                    height: 360.h,
                    width: 343.w,
                  ),
                  SvgPicture.asset(
                    imagePath,
                    height: 323.h,
                    width: 343.w,
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Text(
                title,
                style: AppStyle.textStyle15,
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                mess,
                style: AppStyle.textStyle12
                    .copyWith(color: AppColors.grayDarkColor, fontSize: 15.sp),
                textAlign: TextAlign.start,
              ),
            ],
          ).setCenter(),
        ));
  }
}
