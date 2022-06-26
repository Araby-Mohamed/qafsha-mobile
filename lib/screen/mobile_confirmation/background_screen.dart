import 'package:afsha/Components/Style.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/padding.dart';

class BackGroundScreen extends StatelessWidget {
  final String title, subTitle;
  final Widget pageForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // bottom left
          Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                    color: AppColors.binkLiteColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(1000))),
              )),

          ListView(
            padding: EdgeInsets.zero,
            children: [
              Stack(
                children: [
                  Container(
                    width: 350,
                    height: 250,
                    decoration: BoxDecoration(
                        color: AppColors.binkLiteColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(1000))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.start,
                          style: AppStyle.textStyle15.copyWith(fontSize: 20),
                        ),
                        SizedBox(height: 10),
                        Text(
                          subTitle,
                          textAlign: TextAlign.start,
                          style: AppStyle.textStyle12.copyWith(color: AppColors.blackColor),
                        ),
                      ],
                    ).addPaddingOnly(right: 16),
                  ),
                ],
              ),
              pageForm
            ],
          ),
        ],
      ),
    );
  }

  BackGroundScreen(
      { this.title,  this.subTitle,  this.pageForm});
}
