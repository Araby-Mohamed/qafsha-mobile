import 'dart:io';
import 'package:afsha/model/notification_response_model.dart';
import 'package:afsha/model/store/departments_response_model.dart';
import 'package:afsha/model/store/product_and_fast_food_response_model.dart';
import 'package:afsha/model/store/product_store_details_response_model.dart';
import 'package:afsha/model/store/store_details_response_model.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:flutter/material.dart';

import '../../model/store/store_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class NotificationProvider extends ChangeNotifier {
  bool _notificationLoader = true;
  bool get notificationLoader => _notificationLoader;

  List<NotificationList> _notificationData;
  List<NotificationList> get notificationData => _notificationData;
  set setNotificationData(List<NotificationList> newValue) {
    _notificationData = newValue;
    notifyListeners();
  }


  Future<List<NotificationList>> getNotification({
    BuildContext context,
  }) async {
    _notificationLoader = true;
    Response response = await DioHelper.getData(
      url: EndPoints.notifications,
      withCache: true,
      withAuth: true
    );
    _notificationLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {

      NotificationResponseModel notificationResponseModel = NotificationResponseModel.fromJson(response.data);
      setNotificationData = notificationResponseModel.data;

    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }


  String notificationStatus({String orderStatus}) {
    print('order statussssss => ${orderStatus}');
    String title;
    switch (orderStatus) {
      case Constants.pendingOrder:
        {
          title = "قيد تنفيذ طلبك رقم " ;
        }
        break;
      case Constants.receivedOrder:
        {
          title = "تم تغليف طلبك رقم " ;
        }
        break;
      case Constants.preparationOrder:
        {
          title = "تم توصيل  طلبك رقم " ;
        }
        break;
      case Constants.shippingOrder:
        {
          title = "تم شحن طلبك رقم " ;
        }
        break;
    }
    //notifyListeners();
    return title;
  }
}
