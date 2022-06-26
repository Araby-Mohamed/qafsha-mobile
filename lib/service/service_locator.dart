// @dart=2.10
import 'package:afsha/service/shared_prefrence.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../appProvider.dart';
final GetIt sL = GetIt.I;

Future<void> setupLocators() async {
  final SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sL.registerSingleton<SharedPrefService>(SharedPrefService(sharedPref));

  sL.registerSingleton<AppProvider>(AppProvider());


}
