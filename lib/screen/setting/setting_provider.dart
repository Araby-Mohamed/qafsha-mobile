import 'dart:convert';
import 'dart:io';

import 'package:afsha/model/profile_response_model.dart';
import 'package:afsha/model/setting_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class SettingProvider extends ChangeNotifier {
  bool _getStringLoader = false;
  bool get getStringLoader => _getStringLoader;
  set setStringLoader(bool newVlu) {
    _getStringLoader = newVlu;
    notifyListeners();
  }

  List<SettingData> _settingData;
  List<SettingData> get settingData => _settingData;
  set setSettingData(List<SettingData> newModel) {
    _settingData = newModel;
    notifyListeners();
  }

  void getSettingApi({BuildContext context}) async {
    setStringLoader = true;
    Response response =
        await DioHelper.getData(url: EndPoints.setting, withCache: true);
    setStringLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      SettingResponseModel settingData =
          SettingResponseModel.fromJson(response.data);
      setSettingData = settingData.data;
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }
}
