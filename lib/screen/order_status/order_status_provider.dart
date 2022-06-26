import 'dart:io';
import 'package:afsha/model/order/my_order_response_model.dart';
import 'package:afsha/model/order/order_details_response_model.dart';
import 'package:afsha/model/received_order_response_model.dart';
import 'package:afsha/model/services_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class OrderStatusProvider extends ChangeNotifier {
  bool _orderLoader = true;

  bool get orderLoader => _orderLoader;
  set setOrderLoader(bool newVale) {
    _orderLoader = newVale;
    notifyListeners();
  }

  OrderDetailsResponseModel _orderList;
  OrderDetailsResponseModel get orderList => _orderList;
  set setOrderObject(OrderDetailsResponseModel newList) {
    _orderList = newList;
    notifyListeners();
  }


  int orderStatusIndex({String orderStatus}) {
    print('order statussssss => ${orderStatus}');
    int index;
    switch (orderStatus) {
      case Constants.pendingOrder:
        {
          index = 0;
        }
        break;
      case Constants.preparationOrder:
        {
          index = 1;
        }
        break;
      case Constants.shippingOrder:
        {
          index = 2;
        }
        break;
      case Constants.reachedOrder:
        {
          index = 3;
        }
        break;
      case Constants.receivedOrder:
        {
          index = 4;
        }
        break;
    }
    //notifyListeners();
    return index;
  }

  getOrderDetails({BuildContext context, int orderId}) async {
    _orderLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.orderDetails(orderId: orderId),
        withCache: true,
        withAuth: true);
    _orderLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      setOrderObject = OrderDetailsResponseModel.fromJson(response.data);
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }
  String orderCash({String orderStatus}) {
    String title;
    switch (orderStatus) {
      case Constants.paymentMethod:
        {
          title = 'كاش';
        }
        break;
    }
    return title;
  }

  bool _orderResponseLoader = true;
  bool get orderResponseLoader => _orderResponseLoader;
  set setOrderResponseLoader(bool newVale) {
    _orderResponseLoader = newVale;
    notifyListeners();
  }
  ReceivedOrderResponseModel _orderResponseModel;
  ReceivedOrderResponseModel get orderResponseModel => _orderResponseModel;
  set setOrderResponseObject(ReceivedOrderResponseModel newList) {
    _orderResponseModel = newList;
    notifyListeners();
  }
  getReceivedOrder({BuildContext context}) async {
    setOrderResponseLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.receivedOrder,
        withCache: true,
        withAuth: true);
    setOrderResponseLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      setOrderResponseObject = ReceivedOrderResponseModel.fromJson(response.data);
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  void receivedOrder({
    @required BuildContext context,
    @required int orderId,
    @required VoidCallback onSuccess
  }) async {
    displayCustomCircular(context);
    var body = {
      "order_id": orderId,
    };
    Response response =
    await DioHelper.pastData(url: EndPoints.received(), data: body);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      showToast(message: response.data['message']);
      Navigator.pop(context);
      onSuccess.call();
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = '';
      response.data['errors'].forEach((k, v) {
        for (String mess in v) {
          error += mess + "\n";
        }
      });
      showFlushBar(context: context, message: error);
    } else {}
  }
}
