import 'dart:io';

import 'package:afsha/Components/Widget/ConfirmDialogTwoButton.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/login_screen/login_screen.dart';
import 'package:afsha/screen/profile/profile_screen.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'home_page/home_page.dart';
import 'notification/notification_screen.dart';
import 'orders/orders.dart';

class MainPage extends StatefulWidget {
  final int index;
  MainPage({this.index});
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  _pages() => [
        HomePage(),
        Orders(),
        NotificationScreen(),
        ProfileScreen(),
      ];

  void _onItemTapped(int index) {
    if (index != 0 && index!=1&& index!=2) {
      if (sL<SharedPrefService>().isLoggedIn()) {
        setState(() {
          _selectedIndex = index;
          print(_selectedIndex);
        });
        return;
      }
      showDialog(
        context: context,
        builder: (_) => ConfirmDialogTwoButton(
          title: "هام",
          leftButtonText: "تسجيل",
          onPressLift: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())),
          bgColor: AppColors.mainColor,
          rightButtonText: 'الغاء',
          colorRight: AppColors.binkColor,
          onPress: () => Navigator.pop(context),
          mess: "بالرجاء تسجيل الدخول اولا",
        ),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }

  @override
  void initState() {
    super.initState();
    changePageIndex(widget.index);
  }

  void changePageIndex(int index) {
    if (widget.index == null) {
      _selectedIndex = 0;
    } else {
      _selectedIndex = widget.index;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _onBackPressed();
      },
      child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedLabelStyle: TextStyle(
                color: AppColors.mainColor,
                fontSize: 12,
                fontWeight: FontWeight.bold),
            selectedIconTheme: IconThemeData(
              color: AppColors.mainColor,
            ),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Resources.ICON_HOME,
                    width: 25,
                    height: 25,
                    color: _selectedIndex == 0
                        ? AppColors.mainColor
                        : AppColors.blackColor,
                  ),
                  label: "الرئيسية"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Resources.ICON_CART,
                    width: 25,
                    height: 25,
                    color: _selectedIndex == 1
                        ? AppColors.mainColor
                        : AppColors.blackColor,
                  ),
                  label: "طلباتي"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Resources.ICON_NOTIFICATION,
                    width: 25,
                    height: 25,
                    color: _selectedIndex == 2
                        ? AppColors.mainColor
                        : AppColors.blackColor,
                  ),
                  label: "الإشعارات"),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    Resources.ICON_PROFILE,
                    width: 25,
                    height: 25,
                    color: _selectedIndex == 3
                        ? AppColors.mainColor
                        : AppColors.blackColor,
                  ),
                  label: "حسابي"),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.mainColor,
            unselectedItemColor: AppColors.blackColor,
            unselectedLabelStyle:
                TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            onTap: _onItemTapped,
          ),
          body: _pages()[_selectedIndex]),
    );
  }

  _onBackPressed() {
    return showDialog(
      context: context,
      builder: (_) => ConfirmDialogTwoButton(
        title: "هام",
        leftButtonText: "موافق",
        onPressLift: () => exit(0),
        bgColor: AppColors.mainColor,
        rightButtonText: 'الغاء',
        colorRight: AppColors.binkColor,
        onPress: () => Navigator.pop(context),
        mess: "هل تريد الخروج من التطبيق؟",
      ),
    );
  }
}
