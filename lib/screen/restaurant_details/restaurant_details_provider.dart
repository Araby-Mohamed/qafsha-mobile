import 'dart:io';
import 'package:afsha/model/store/departments_response_model.dart';
import 'package:afsha/model/store/product_and_fast_food_response_model.dart';
import 'package:afsha/model/store/product_store_details_response_model.dart';
import 'package:afsha/model/store/store_details_response_model.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:flutter/material.dart';

import '../../model/store/store_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:afsha/extensions/extension.dart';

class RestaurantsDetailsProvider extends ChangeNotifier {
  bool _continueOrder = false;
  bool get continueOrder => _continueOrder;
  set setContinueOrderValue(bool newVlu) {
    _continueOrder = newVlu;
    notifyListeners();
  }

  ///
  bool _storeDetailsLoader = false;
  bool get storeDetailsLoader => _storeDetailsLoader;
  set setStoreDetailsLoader(bool newVlu) {
    _storeDetailsLoader = newVlu;
    notifyListeners();
  }

  List<Addition> _checkBoxAdditions = <Addition>[];
  List<Addition> get checkBoxAdditions => _checkBoxAdditions;
  addNewItem(Addition newItem) {
    _checkBoxAdditions.add(newItem);
    notifyListeners();
  }

  removeItem(Addition newItem) {
    _checkBoxAdditions.remove(newItem);
    notifyListeners();
  }

  StoreDetailsData _storeDetailsData;
  StoreDetailsData get storeDetailsData => _storeDetailsData;
  set setStoreDetailsData(StoreDetailsData newValue) {
    _storeDetailsData = newValue;
    notifyListeners();
  }

  /// department
  bool _storeDepartmentLoader = true;
  bool get storeDepartmentLoader => _storeDepartmentLoader;

  List<DepartmentsDataList> _storeDepartmentData;
  List<DepartmentsDataList> get storeDepartmentData => _storeDepartmentData;
  set setStoreDepartmentData(List<DepartmentsDataList> newValue) {
    _storeDepartmentData = newValue;
    notifyListeners();
  }

  ///
  bool _productStoreDetailsLoader = true;
  bool get productStoreDetailsLoader => _productStoreDetailsLoader;
  set setProductStoreDetailsLoader(bool newValue) {
    _productStoreDetailsLoader = newValue;
    notifyListeners();
  }

  ProductStoreDetailsData _productStoreDetailsData = ProductStoreDetailsData();
  ProductStoreDetailsData get productStoreDetailsData =>
      _productStoreDetailsData;
  set setProductStoreDetailsData(ProductStoreDetailsData newValue) {
    _productStoreDetailsData = newValue;
    notifyListeners();
  }

  ///
  bool _productFastFoodLoader = false;
  bool get productFastFoodLoader => _productFastFoodLoader;
  set setProductFastFoodLoader(bool newVale) {
    _productFastFoodLoader = newVale;
    notifyListeners();
  }

  List<ProductAndFastFoodData> _productFastFoodList =
      <ProductAndFastFoodData>[];
  List<ProductAndFastFoodData> get productFastFoodList => _productFastFoodList;
  set setProductFastFoodList(List<ProductAndFastFoodData> newList) {
    _productFastFoodList.addAll(newList);
    notifyListeners();
  }

  void getStore({
    BuildContext context,
    @required int restaurantId,
  }) async {
    setStoreDetailsLoader = true;
    Response response = await DioHelper.getData(
      url: EndPoints.storesDetails(restaurantId: restaurantId),
      withCache: true,
    );
    setStoreDetailsLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      setStoreDetailsData = StoreDetailsData.fromJson(response.data['data']);
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  /// store Department
  Future<List<DepartmentsDataList>> getStoreDepartment(
      {BuildContext context, @required int storeId}) async {
    _storeDepartmentLoader = true;
    Response response = await DioHelper.getData(
      url: EndPoints.storesDepartments(storeId: storeId),
      withCache: true,
    );
    _storeDepartmentLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      DepartmentsResponseModel departmentsResponseModel =
          DepartmentsResponseModel.fromJson(response.data);
      setStoreDepartmentData = departmentsResponseModel.data;

      _productFastFoodList.clear();
      notifyListeners();

      if (_storeDepartmentData.length > 0) {
        getProductAndFastFood(
          context: context,
          storeDepartmentId: _storeDepartmentData.first.id,
          storeId: storeId,
        );
      }
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
    print("Departments Data List length  ${_storeDepartmentData.length}");
    return _storeDepartmentData;
  }

  int _storeDepId;
  set setStoreDepId(int id) {
    _storeDepId = id;
    notifyListeners();
  }

  int _pageNo = 1;
  incrementPageNo() {
    _pageNo++;
    notifyListeners();
  }

  resetPageNo() {
    _pageNo = 1;
    notifyListeners();
  }

  int _storeId;
  set setStoreId(int id) {
    _storeId = id;
    notifyListeners();
  }

  bool _getMoreData = false;
  bool get getMoreData => _getMoreData;
  set setGetMoreDataLoader(bool newVlu) {
    _getMoreData = newVlu;
    notifyListeners();
  }

  /// store Product And Fast Food
  /// Future<List<ProductAndFastFoodData>>
  void getProductAndFastFood(
      {BuildContext context,
      @required int storeDepartmentId,
      int storeId}) async {
    setStoreDepId = storeDepartmentId ?? _storeDepId;
    setStoreId = storeId ?? _storeId;

    if (_pageNo == 1) {
      _productFastFoodList.clear();
      notifyListeners();
    }

    if (_pageNo != 1) {
      setGetMoreDataLoader = true;
    } else {
      setProductFastFoodLoader = true;
    }

    Response response = await DioHelper.getData(
      url: EndPoints.productAndFastFoodDetails(
          storeDepartmentId: _storeDepId, storeId: _storeId, page: _pageNo),
      withCache: true,
    );

    if (_pageNo != 1) {
      setGetMoreDataLoader = false;
    } else {
      setProductFastFoodLoader = false;
    }
    print('loader => $productFastFoodLoader');
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      ProductAndFastFoodResponseModel productAndFastFoodResponseModel =
          ProductAndFastFoodResponseModel.fromJson(response.data);

      setProductFastFoodList = productAndFastFoodResponseModel.data;
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
    print("  product FastFoodList length  ${_productFastFoodList.length}");
  }

  /// Product Details
  void getProduct({
    BuildContext context,
    @required int productId,
  }) async {
    _productStoreDetailsLoader = true;
    Response response = await DioHelper.getData(
      url: EndPoints.productDetails(productsId: productId),
      withCache: true,
    );
    _productStoreDetailsLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      setProductStoreDetailsData =
          ProductStoreDetailsData.fromJson(response.data['data']);
      resetCalculatePrice(productStoreDetailsData.price.toDouble());
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  /// counter order addition
  int _count = 1;
  int get count => _count;
  set setCounter(int newVlu) {
    _count = newVlu;
    notifyListeners();
  }

  void resetCounter() {
    setCounter = 1;
  }

  double _calculatedPrice;
  double get calculatedPrice => _calculatedPrice;

  double defaultPrice(double price) {
    return count * price;
  }

  resetCalculatePrice(double price) {
    _calculatedPrice = price * count;
  }

  void increment(double price) {
    _count++;
    calculatePrice(_count, price);
    notifyListeners();
  }

  void decrement(double price) {
    _count--;
    calculatePrice(_count, price);
    notifyListeners();
  }

  void calculatePrice(int quantity, double price) {
    _calculatedPrice = quantity * price;
    notifyListeners();
  }

  /// set cart
  void setCartApi(
      {@required BuildContext context,
      @required String productId,
      @required String quantity,
      VoidCallback onSuccess}) async {
    displayCustomCircular(context);
    var body = {
      "product_id": productId,
      "quantity": quantity,
    };
    if (checkBoxAdditions.length > 0) {
      for (int i = 0; i < checkBoxAdditions.length; ++i) {
        String key = "additions[" + i.toString() + "]";
        body.addAll({key: checkBoxAdditions[i].id.toString()});
      }
    }

    print('body => $body');
    Response response = await DioHelper.pastData(
        url: EndPoints.setCart(), data: body, withAuth: true);
    closeCustomCircular(context);
    onSuccess.call();
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      showToast(message: response.data['message']);
      setContinueOrderValue = true;
      Navigator.pop(context);
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      closeCustomCircular(context);
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
