import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  SharedPrefService(this._preferences);

  final SharedPreferences _preferences;

  Future<void> saveUserToken(String accessToken) async {
    await _preferences.setString('token', accessToken);
    print('getUserToken SharedPrefService => ${getUserToken()}');
  }
  Future<void> saveDevicesToken(String accessToken) async {
    await _preferences.setString('device_token', accessToken);
    print('device token SharedPrefService => ${getUserToken()}');
  }
  String getDevicesToken() {
    print('get Devices Token  => ${_preferences.getString('device_token')}');
     return _preferences.getString('device_token');
  }
  Future<void> saveUserName(String userName) async {
    await _preferences.setString('userName', userName);
  }

  String getUserName() {
    return _preferences.getString('userName');
  }

  Future<void> removeUserName() async {
    await _preferences.remove('userName');
  }

  Future<void> removeUserToken() async {
    await _preferences.remove('token');
  }

  String getUserToken() {
    return _preferences.getString('token');
  }
  Future<void> saveUserId(String userId) async {
    await _preferences.setString('user_id', userId);
  }
  String getUserId() {
    return _preferences.getString('user_id');
  }

  Future<void> changeAuthStatus(bool value) async {
    await _preferences.setBool("isAuth", value);
  }

  bool isLoggedIn() {
    return _preferences.getBool("isAuth") ?? false;
  }
}
