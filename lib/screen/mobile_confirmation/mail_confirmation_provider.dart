import 'dart:convert';
import 'dart:io';

import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/screen/mobile_confirmation/mail_confirmation.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MailConfirmationProvider extends ChangeNotifier {
  void mailConfirmationApi({
    @required BuildContext context,
    @required String verifyCode,
    bool autoNavigateToLastScreen = false,
    @required VoidCallback callBack,
  }) async {
    displayCustomCircular(context);
    var body = {
      "verify_code": verifyCode,
    };
    Response response =
        await DioHelper.pastData(url: EndPoints.verify, data: body);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      sL<SharedPrefService>().changeAuthStatus(true);
      sL<SharedPrefService>().saveUserToken(response.data['data']['access_token']);
      sL<SharedPrefService>().saveUserId(response.data['data']['user_id'].toString());
      devicesApi();
     showToast(message: 'تم التسجيل بنجاح');

      if (autoNavigateToLastScreen == true) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        print('autoNavigateToLastScreen => $autoNavigateToLastScreen');
        if (callBack != null) callBack();
      }
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = '';
      response.data['errors'].forEach((k, v) {
        for (String mess in v) {
          error += mess + "\n";
        }
      });
      showFlushBar(context: context, message: error);
    } else {
      closeCustomCircular(context);
    }
  }

  void devicesApi({
    @required BuildContext context,
    @required String deviceToken,
  }) async {
    var body = {
      "device_token": sL<SharedPrefService>().getDevicesToken(),
    };
    Response response = await DioHelper.pastData(
        url: EndPoints.devices, data: body, withAuth: true);

    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      print('done device =>');
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
