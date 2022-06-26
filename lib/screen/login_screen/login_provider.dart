import 'dart:convert';
import 'dart:io';

import 'package:afsha/Components/Widget/ConfirmDialogTwoButton.dart';
import 'package:afsha/screen/login_screen/login_screen.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/screen/mobile_confirmation/mail_confirmation.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  void loginApi(
      {@required BuildContext context,
      @required String phone,
      bool withNavigate = true}) async {
    displayCustomCircular(context);
    var body = {
      "phone": phone,
    };
    Response response =
        await DioHelper.pastData(url: EndPoints.LOGIN, data: body);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      showToast(message: response.data['message']);
      if (withNavigate == false) return;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MailConfirmation(
                    phone: phone,
                  )));
      // NavigatorX.push(
      //     context,
      //     MailConfirmation(
      //       autoNavigateToLastScreen: autoNavigateToLastScreen,
      //     ));
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = response.data['message'];
      // response.data['errors'].forEach((k, v) {
      //   for (String mess in v) {
      //     error += mess + "\n";
      //   }
      // });
      showFlushBar(context: context, message: error);
    } else {}
  }

  void logOutApi({
    @required BuildContext context,
  }) async {
    displayCustomCircular(context);
    Response response =
        await DioHelper.pastData(url: EndPoints.LOGOUT, withAuth: true);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      sL<SharedPrefService>().changeAuthStatus(false);
      sL<SharedPrefService>().removeUserToken();
      NavigatorX.push(context, LoginScreen());
    } else if (response.statusCode == HttpStatus.unauthorized) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
  }

  formValidationLogin(
      {@required String phone,
      @required BuildContext context,
      bool autoNavigateToLastScreen = false}) async {
    if (phone.isEmpty) {
      showFlushBar(
        context: context,
        message: "برجاء  إدخال  رقم  هاتفك",
      );
    } else {
      loginApi(
        phone: phone,
        context: context,
      );
    }
  }
}
