import 'dart:io';
import 'package:afsha/model/services_response_model.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import '../../model/store/store_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class RestaurantsProvider extends ChangeNotifier {
  bool _storeLoader = true;
  bool get storeLoader => _storeLoader;
  set setStoreLoader(bool newVale) {
    _storeLoader = newVale;
    notifyListeners();
  }

  bool _startSearch = false;
  bool get startSearch => _startSearch;
  set setStartSearch(bool newVale) {
    _startSearch = newVale;
    notifyListeners();
  }

  List<StoreDataList> _storeList;
  set setStoreList(List<StoreDataList> newList) {
    _storeList = newList;
    notifyListeners();
  }

  List<StoreDataList> _searchResultStoreList;
  List<StoreDataList> get searchResultStoreList => _searchResultStoreList;
  set setSearchResultStoreList(List<StoreDataList> newList) {
    _searchResultStoreList = newList;
    notifyListeners();
  }

  Future<List<StoreDataList>> getStore({
    BuildContext context,
    @required int pageNumber,
    @required int idServices,
  }) async {
    _storeLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.stores(pageNumber: pageNumber, idServices: idServices),
        withCache: true,
        withAuth: false);
    _storeLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      StoreResponseModel storeResponseModel =
          StoreResponseModel.fromJson(response.data);
      setStoreList = storeResponseModel.data.data;
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
    print(" store List length  ${_storeList.length}");
    return _storeList;
  }

  getSearch({BuildContext context, int pageNumber, String title}) async {
    setStartSearch = true;
    displayCustomCircular(context);
    Response response = await DioHelper.getData(
        url: EndPoints.search(pageNumber: pageNumber, title: title),
        withCache: true,
        withAuth: true);
    closeCustomCircular(context);
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      StoreResponseModel storeResponseModel =
          StoreResponseModel.fromJson(response.data);
      setSearchResultStoreList = storeResponseModel.data.data;
      print('Done Search');
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }
}
