import 'dart:async';
import 'package:afsha/screen/captains_list/offer_provider.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'Components/resources.dart';
import 'onBoarding/Main_onBoarding.dart';
import 'screen/ pick_location/location_provider.dart';
import 'screen/main_page_screen.dart';
import 'service/service_locator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Component UI
class _SplashScreenState extends State<SplashScreen> {
  /// Setting duration in splash screen

  handleNavigatePage() async {
    !sL<SharedPrefService>().isLoggedIn()
        ? NavigatorX.push(context, OnBoarding())
        : NavigatorX.push(
            context,
            MainPage(
              index: 0,
            ));
  }
  startTime() {
    return new Timer(Duration(seconds: 5), handleNavigatePage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
    context.read<LocationProvider>().getPermission();
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColors.gradient,
          ),
          child: Container(
            child: Center(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(Resources.SplashScreen),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
