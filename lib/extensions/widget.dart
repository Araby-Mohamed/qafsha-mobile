import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
extension WidgetX on Widget {
  // Widget needLogin() {
  //   print('logged in => ${sL<SharedPrefService>().isLoggedIn()}');
  //   if (sL<SharedPrefService>().isLoggedIn()) return SizedBox(child: this);
  //   return InkWell(
  //     child: this,
  //     onTap: () {
  //       showDialog(
  //           context: sL<AppProvider>().navigatorKey.currentContext,
  //           barrierDismissible: true,
  //           barrierColor: Colors.black.withOpacity(0.5),
  //           builder: (BuildContext context) {
  //             return YesNoAlertDialog(
  //               titleText: 'يجب عليك تسجيل الدخول أولاً',
  //               yesBtnText: 'الذهاب لتسجيل الدخول',
  //               onYesPressed: () {
  //                 Navigator.push(context,
  //                     MaterialPageRoute(builder: (context) => LoginScreen()));
  //               },
  //             );
  //           });
  //     },
  //   );
  // }

  Widget setCenter() {
    return Center(
      child: this,
    );
  }

  Widget setWidth(double width) {
    return Container(width: width, child: this);
  }

  Widget disableBackButton() {
    return WillPopScope(
      child: this,
      onWillPop: () async => false,
    );
  }

  Widget setHeight(double height) {
    return Container(height: height, child: this);
  }

  Widget shimmerWhenLoading(bool loading, {Color baseColor, Color highlightColor, Duration duration}) {
    if (loading ?? false) {
      return Shimmer.fromColors(
        period: duration ?? Duration(milliseconds: 1000),
        direction: ShimmerDirection.rtl,
        baseColor: baseColor ?? (Colors.grey[300]),
        highlightColor: highlightColor ?? (Colors.grey[100]),
        child: this,
      );
    }
    return this;
  }
}
