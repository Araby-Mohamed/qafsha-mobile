

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
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationProvider extends ChangeNotifier {

  bool remember = false;
  changeRemember(bool value) {
    remember = value;
    notifyListeners();
  }
  void registrationApi({
    @required BuildContext context,
    @required String phone,
    @required String username,
    @required String email,
    @required String gender,
  }) async {
    displayCustomCircular(context);
    var body = {
      "phone": phone,
      "username": username,
      "email": email,
      "gender": gender,
    };
    Response response = await DioHelper.pastData(url: EndPoints.REGISTRATION, data: body);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
      print('DONEEEEEEEEEEEEEEEEEEE');
      showToast(message: response.data['message']);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MailConfirmation()));
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = '';
      response.data['errors'].forEach((k, v) {
        for (String mess in v) {
          error += mess + "\n";
        }
      });
      showFlushBar(context: context, message: error);
    }  else {
      closeCustomCircular(context);
    }
  }

  formValidationRegistration(
      {@required String phone,
        @required String username,
        @required String email,
        String gender,
        @required BuildContext context}) async {
    if (phone.isEmpty && username.isEmpty&& email.isEmpty) {
      showFlushBar(context: context, message:  "برجاء  إدخال بياناتك",);
    }else if (username.isEmpty) {
      showFlushBar(context: context, message:  "برجاء  إدخال  إسمك",);
    } else if (email.isEmpty) {
      showFlushBar(context: context, message:  "برجاء  إدخال البريد الإلكتروني ",);
    } else if (phone.isEmpty) {
      showFlushBar(context: context, message:  "برجاء  إدخال  رقم  هاتفك",);
    } else {
      registrationApi(
        phone: phone,
        email: email,
        username: username,
        gender: gender,
        context: context,
      );
    }
  }
}

