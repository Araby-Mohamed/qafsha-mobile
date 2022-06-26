import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/notification_response_model.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/utils/components.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var notificationProvider = context.read<NotificationProvider>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationProvider.getNotification(
        context: context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var notifications = context.watch<NotificationProvider>();

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'الإشعارات',
            style: AppStyle.textStyle15,
          ),
          automaticallyImplyLeading: false,
        ),
        body: notifications.notificationLoader ?
        horizontalShimmer(context: context,height: 68.h,itemCount: 4)
            : (notifications?.notificationData?.length ?? 0) > 0
            ? ListView(
                shrinkWrap: true,
                children: notifications.notificationData
                    .map((e) => _notificationBody(e))
                    .toList(),
              )
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: AssetImage(Resources.NOTIFICATION)),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'لا يوجد إشعارات في الوقت الحالي',
                      style: AppStyle.textStyle15.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              ));
  }

  Widget _notificationBody(NotificationList notificationList) {
    var notifications = context.watch<NotificationProvider>();

    return InkWell(
      //  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetails())),
      child: Container(
        height: 68.h,
        decoration: BoxDecoration(
            color: AppColors.whiteColor, boxShadow: AppColors.boxShadow),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: 68.h,
                decoration: BoxDecoration(gradient: AppColors.gradient),
                child:   Image(image: AssetImage(Resources.NOTIFICATION_LOGO),fit: BoxFit.cover,),

              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 4,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 9.h,
                    ),
                    /*          RichText(
                      text: TextSpan(
                        text: '',
                       // children: ' تم تعبئة وشحن طلبك رقم 32323'
                        children:  notificationList.orderNumber.toString()
                            .split('')
                            .map(
                              (e) => TextSpan(
                                text: e,
                                style: TextStyle(
                                  color: int.tryParse(e) == null
                                      ? AppColors.blackColor
                                      : AppColors.mainColor,
                                  fontSize: 12.sp,
                                  fontFamily: "CairoRegular",
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),*/

                    RichText(
                      text: TextSpan(
                        text: notifications.notificationStatus(
                            orderStatus: notificationList.status),
                        style: AppStyle.textStyle12,
                        children: <TextSpan>[
                          TextSpan(
                              text: notificationList.orderNumber.toString(),
                              style: TextStyle(color: AppColors.mainColor)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '',
                        children: notificationList.date
                            .split('')
                            .map(
                              (e) => TextSpan(
                                text: e,
                                style: TextStyle(
                                  color: int.tryParse(e) == null
                                      ? AppColors.blackColor
                                      : AppColors.mainColor,
                                  fontSize: 12.sp,
                                  fontFamily: "CairoRegular",
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ).addPaddingHorizontalVertical(vertical: 7);
  }
}
