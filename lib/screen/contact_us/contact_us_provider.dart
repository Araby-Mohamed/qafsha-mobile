import 'dart:io';

import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class ContactUsProvider extends ChangeNotifier {
  void contactApi({
    @required BuildContext context,
    @required String email,
    @required String name,
    @required String phone,
    @required String subject,
    @required String message,
  }) async {
    displayCustomCircular(context);
  var body = {
    "email": email,
    "name": name,
    "phone":phone,
    "subject": subject,
    "message":message,
  };
  Response response = await DioHelper.pastData(url: EndPoints.messages, data: body,withAuth: true);
    closeCustomCircular(context);
  if (response.statusCode == HttpStatus.ok || response.statusCode == HttpStatus.created) {
    showToast(message: response.data['message']);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainPage(index: 0,)));
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