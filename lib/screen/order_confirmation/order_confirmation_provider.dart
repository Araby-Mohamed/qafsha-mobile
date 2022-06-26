import 'dart:convert';
import 'dart:io';

import 'package:afsha/model/before_confirm_response_model.dart';
import 'package:afsha/model/cart_response_model.dart';
import 'package:afsha/screen/order_confirmation%20_done/order_confirmation%20_done.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderConfirmationProvider extends ChangeNotifier {
  bool _cardLoader = false;
  bool get cardLoader => _cardLoader;
  set setCartLoader(bool newVlu) {
    _cardLoader = newVlu;
    notifyListeners();
  }

  CartResponseModel _cartResponseModel;
  CartResponseModel get cartResponseModel => _cartResponseModel;
  set setCartModel(CartResponseModel newModel) {
    _cartResponseModel = newModel;
    notifyListeners();
  }

  bool _beforeConfirmLoader = false;
  bool get beforeConfirmLoader => _beforeConfirmLoader;
  set setBeforeConfirmLoader(bool newVlu) {
    _beforeConfirmLoader = newVlu;
    notifyListeners();
  }

  BeforeConfirmResponseModel _beforeConfirmResponseModel;
  BeforeConfirmResponseModel get beforeConfirmResponseModel =>
      _beforeConfirmResponseModel;
  set setBeforeConfirmResponseModel(BeforeConfirmResponseModel newModel) {
    _beforeConfirmResponseModel = newModel;
    notifyListeners();
  }

  Map _jsonData;
  set setJsonData(Map data) {
    _jsonData = data;
    notifyListeners();
  }

  List<CardOrders> _list = <CardOrders>[];
  List<CardOrders> get productList => _list;
  setList(CardOrders newList) {
    _list = <CardOrders>[];
    _list.add(newList);
    notifyListeners();
  }

  initList(Map newData) {
    newData.forEach((key, value) {
      if (value is List) {
        List<OrderProductData> _listDemo = <OrderProductData>[];
        _listDemo = List<OrderProductData>.from(
            value.map((x) => OrderProductData.fromJson(x)));
        CardOrders cardOrders =
            CardOrders(storeList: key, productsList: [..._listDemo]);
        setList(cardOrders);
      }
    });
  }

  void getBeforeConfirm({
    BuildContext context,
  }) async {
    setBeforeConfirmLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.beforeConform(), withCache: true, withAuth: true);
    setBeforeConfirmLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      if (response.data['data'] is Map) {
        setBeforeConfirmResponseModel =
            BeforeConfirmResponseModel.fromJson(response.data);
        initList(response.data['data']);
        return;
      }
      _list = <CardOrders>[];
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  void cartDelete({BuildContext context, int cardId}) async {
    setCartLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.cardDelete(cardDeleteId: cardId),
        withCache: true,
        withAuth: true);
    setCartLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      getBeforeConfirm(context: context);
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  void updateQuantity({
    BuildContext context,
    @required String cardId,
    @required int quantity,
  }) async {
    var body = {"cart_id": cardId, "quantity": quantity};
    displayCustomCircular(context);
    Response response = await DioHelper.pastData(
        data: body, url: EndPoints.getCartUpdate(), withAuth: false);
    closeCustomCircular(context);
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      getBeforeConfirm(context: context);
      setCartModel = CartResponseModel.fromJson(response.data);
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  void doneOrder({
    BuildContext context,
  }) async {
    var body = {};
    displayCustomCircular(context);
    Response response = await DioHelper.pastData(
        data: body, url: EndPoints.doneOrder(), withAuth: false);
    closeCustomCircular(context);
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      getBeforeConfirm(context: context);
      setCartModel = CartResponseModel.fromJson(response.data);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => OrderConfirmationDone()));
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }
}
