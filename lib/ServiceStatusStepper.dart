import 'package:afsha/extensions/padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines/timelines.dart';

import 'Components/Style.dart';
import 'tools/AppColors.dart';
import 'tools/Constants.dart';

class ServiceStatusStepper extends StatelessWidget {
  final int processIndex;
  final ValueChanged<int> onChanged;
  final String receivedText;
  ServiceStatusStepper(
      {@required this.processIndex, this.onChanged, this.receivedText});
  // int processIndex = 2;
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
            ).addPaddingOnly(
                bottom: 5.h,
                right: Constants.orderDetailsTitles[index] ==
                        Constants.orderDetailsTitles.first
                    ? 17
                    : 0);
          },
          indicatorBuilder: (_, index) {
            var child;
            if (index == processIndex) {
              child = Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mainColor,
                      border: Border.all(color: AppColors.grayColor)),
                ),
              );
            } else if (index < processIndex) {
              child = Container(
                width: 20.w,
                height: 20.h,
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
                  size: 13,
                )),
              );
            }

            if (index <= processIndex) {
              return child;
            } else {
              return Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.mainColor)),
              );
            }
          },
          connectorBuilder: (_, index, type) {
            return Container(
              width: 60,
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
