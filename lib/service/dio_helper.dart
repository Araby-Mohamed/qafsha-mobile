import 'dart:io';
import 'package:afsha/appProvider.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/network.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DioHelper {
  static Dio dio;
  static init() async {
    // _dioCacheManager = DioCacheManager(CacheConfig());
    // _cacheOptions = buildCacheOptions(Duration(minutes: 10));

    dio = Dio(
      BaseOptions(
        baseUrl: 'https://qafshah.com.sa/api/user/v1',
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status < 500;
        },
        headers: {
          'accept': 'application/json',
          'access-key':
              'GrU#}?a}^]8`#AbR3pRU+Apf%Kw[@]yp5{2X^}N*4\$#vCtF4_wW\$\$*!tDmq3',
        },
      ),
    );

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    var cookieJar =
        PersistCookieJar(storage: FileStorage(appDocPath + "/.cookies/"));
    dio.interceptors.add(CookieManager(cookieJar));

    dio.interceptors
      ..add(LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
      ));
  }

  static Future<Response> getData({
    String url,
    bool withAuth = false,
    bool withCache = false,
    Map<String, dynamic> query,
  }) async {
    final bool isUserConnected = await NetworkUtilities.isConnected();
    if (isUserConnected == false) {
      showToast(message: Constants.NETWORK_ERROR_MESS);
      return null;
    }
    if (withAuth) {
      dio.options.headers["authorization"] =
          "bearer ${sL<SharedPrefService>().getUserToken()}}";
         // "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvcWFmc2hhaC5jb20uc2FcL2FwaVwvdXNlclwvdjFcL2F1dGhcL3ZlcmlmeSIsImlhdCI6MTYzODIyMjI0NiwiZXhwIjoxNjQwODE0MjQ2LCJuYmYiOjE2MzgyMjIyNDYsImp0aSI6IlhaT21iQVFNeDFUdll2azUiLCJzdWIiOjYsInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.tkJ10HLeqDtnzRIi6os-1VtGAQ26uuNlAo6lWJ4jHls}";
    }

    print('use token => ${sL<SharedPrefService>().getUserToken()}');
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> pastData({
    String url,
    Map<String, dynamic> query,
    bool withAuth = false,
    dynamic data,
  }) async {
    final bool isUserConnected = await NetworkUtilities.isConnected();
    if (isUserConnected == false) {
      showToast(message: Constants.NETWORK_ERROR_MESS);
      closeCustomCircular(sL<AppProvider>().navigatorKey.currentContext);
      return null;
    }
    if (withAuth) {
      dio.options.headers["authorization"] =
          "bearer ${sL<SharedPrefService>().getUserToken()}";
      print("withAuth => ${sL<SharedPrefService>().getUserToken()} ");
    }
    print('dio.options.headers' + dio.options.headers.toString());

    return dio.post(url, queryParameters: query, data: data);
  }

  static Future<Response> putData({
    String url,
    Map<String, dynamic> query,
    bool withAuth = false,
    dynamic data,
  }) async {
    final bool isUserConnected = await NetworkUtilities.isConnected();
    if (isUserConnected == false) {
      showToast(message: Constants.NETWORK_ERROR_MESS);
      closeCustomCircular(sL<AppProvider>().navigatorKey.currentContext);
      return null;
    }

    if (withAuth) {
      dio.options.headers["authorization"] =
          "Bearer ${sL<SharedPrefService>().getUserToken()}";
    }

    return dio.put(url, queryParameters: query, data: data);
  }

  static Future<Response> delete({
    String url,
    Map<String, dynamic> query,
    bool withAuth = false,
    Map<String, dynamic> data,
  }) async {
    final bool isUserConnected = await NetworkUtilities.isConnected();
    if (isUserConnected == false) {
      showToast(message: Constants.NETWORK_ERROR_MESS);
      return null;
    }
    return dio.delete(url, queryParameters: query, data: data);
  }
}
