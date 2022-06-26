import 'package:afsha/Components/Style.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:afsha/extensions/extension.dart';
class OrderStatusStepper extends StatelessWidget {
  const OrderStatusStepper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        theme: TimelineThemeData(
          direction: Axis.horizontal,
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
              MediaQuery.of(context).size.width /
              Constants.orderDetailsTitles.length,
          oppositeContentsBuilder: (context, index) {
            return Text(
              Constants.orderDetailsTitles[index],
              style: AppStyle.textStyle12,
            ).addPaddingOnly(bottom: 5.h);
          },
          indicatorBuilder: (_, index) {
            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.mainColor,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: AppColors.mainColor,
                    width: 1,
                  ),
                ),
              ),
              child: Center(
                  child: Icon(
                Icons.check,
                color: Colors.white,
                size: 18,
              )),
            );
          },
          connectorBuilder: (_, index, type) {
            return Container(
              width: 40,
              color: AppColors.binkColor,
              height: 1,
            );
          },
          itemCount: Constants.orderDetailsTitles.length,
        ),
      ),
    );
  }
}
