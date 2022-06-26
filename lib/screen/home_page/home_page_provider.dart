import 'dart:io';
import 'package:afsha/model/services_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class HomePageProvider extends ChangeNotifier {
  bool _servicesLoader = true;

  bool get servicesLoader => _servicesLoader;
  set setServicesLoader(bool newVale) {
    _servicesLoader = newVale;
    notifyListeners();
  }


  List<ServicesDataList> _servicesList;
  set setServicesList(List<ServicesDataList> newList) {
    _servicesList = newList;
    notifyListeners();
  }

  Future<List<ServicesDataList>> getServices({ BuildContext context, @required int pageNumber}) async {
    _servicesLoader = true;
    Response response = await DioHelper.getData(url: EndPoints.services(pageNumber: pageNumber),withCache: true);
    _servicesLoader = false;
    if (response?.statusCode == HttpStatus.ok || response?.statusCode == HttpStatus.created) {
      ServicesResponseModel servicesResponseModel = ServicesResponseModel.fromJson(response.data);
      setServicesList = servicesResponseModel.data.data;
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
    print(" servicesList length  ${_servicesList.length}");
    return _servicesList;
  }
}
