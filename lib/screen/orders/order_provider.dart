import 'dart:io';
import 'package:afsha/model/order/my_order_response_model.dart';
import 'package:afsha/model/services_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {
  bool _orderLoader = true;

  bool get orderLoader => _orderLoader;
  set setOrderLoader(bool newVale) {
    _orderLoader = newVale;
    notifyListeners();
  }
  List<OrderDataList> _orderList;
  List<OrderDataList> get orderList => _orderList;
  set setOrderList(List<OrderDataList> newList) {
    _orderList = newList;
    notifyListeners();
  }
  getOrder({ BuildContext context, }) async {
    setOrderLoader = true;
    Response response = await DioHelper.getData(url: EndPoints.order(),withCache: true,withAuth: true);
    setOrderLoader = false;
    if (response?.statusCode == HttpStatus.ok || response?.statusCode == HttpStatus.created) {
      MyOrderResponseModel myOrderResponseModel = MyOrderResponseModel.fromJson(response.data);
      setOrderList = myOrderResponseModel.data;
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }
  String orderTitle({String orderStatus}) {
    print('order statussssss => ${orderStatus}');
    String title;
    switch (orderStatus) {
      case Constants.pendingOrder:
        {
          title = "قيد تنفيذ" ;
        }
        break;
      case Constants.receivedOrder:
        {
          title = "تم الاستلام" ;
        }
        break;
      case Constants.preparationOrder:
        {
          title = "تم التغليف" ;
        }
        break;
      case Constants.shippingOrder:
        {
          title = "تم شحن" ;
        }
        break;
      case Constants.reachedOrder:
        {
          title = "تم التوصيل" ;
        }
        break;
      case Constants.canceledOrder:
        {
          title = "تم الالغاء" ;
        }
        break;
    }
    //notifyListeners();
    return title;
  }
}
