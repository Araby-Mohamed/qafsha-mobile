import 'dart:convert';
import 'dart:io';

import 'package:afsha/model/profile_response_model.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:afsha/extensions/extension.dart';

class EditProfileProvider extends ChangeNotifier {
  bool _getUserProfileLoader = false;
  bool get getUserProfileLoader => _getUserProfileLoader;
  set setUserProfileLoader(bool newVlu) {
    _getUserProfileLoader = newVlu;
    notifyListeners();
  }

  UserProfile _userProfileResponseModel;
  UserProfile get userProfileResponseModel => _userProfileResponseModel;
  set setUserProfileResponseModel(UserProfile newModel) {
    _userProfileResponseModel = newModel;
    notifyListeners();
  }

  void getProfile({BuildContext context}) async {
    setUserProfileLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.profile, withCache: true, withAuth: true);
    setUserProfileLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      setUserProfileResponseModel = UserProfile.fromJson(response.data['data']);
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  void updateProfileApi(
      {@required BuildContext context,
      @required VoidCallback callBack,
      @required String firstName,
      @required String email,
      @required File image,
      @required String phone}) async {

    FormData formData;
    formData = new FormData.fromMap({
      "username": firstName,
      "email": email,
      "phone": phone,
    });

    if (image != null) {
      formData.files.add(MapEntry("image", await image.toMultipartFile()));
    }

    displayCustomCircular(context);
    Response response = await DioHelper.pastData(
        url: EndPoints.updateProfile, withAuth: true, data: formData);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      if (callBack != null) callBack();
      showToast(message: response.data['message']);
    } else if (response.statusCode == HttpStatus.methodNotAllowed) {
      for (String mess in response.data['errors']) {
        showToast(message: mess);
      }
    } else {}
  }
}
