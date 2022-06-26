import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/captains_list/captains_list.dart';
import 'package:afsha/screen/captains_list/offer_provider.dart';
import 'package:afsha/screen/login_screen/login_screen.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:provider/provider.dart';
class OrderConfirmationDone extends StatefulWidget {
  final int orderId;

  OrderConfirmationDone({this.orderId});

  @override
  _OrderConfirmationDoneState createState() => _OrderConfirmationDoneState();
}

class _OrderConfirmationDoneState extends State<OrderConfirmationDone> {
  Widget iconWidget = Icon(
    Icons.check,
    size: 50,
    color: AppColors.whiteColor,
  );
  String textTitle = "تم تأكيد الطلب بنجاح";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<OfferProvider>().initPusher(context: context,);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        iconWidget = CupertinoActivityIndicator();
        textTitle = 'في انتظار العروض المتاحة';
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Container(
          height: context.height,
          width: context.width,
          decoration: BoxDecoration(
              gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.binkColor, Colors.white],
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 65,
                  backgroundColor: AppColors.mainColor,
                  child: iconWidget),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    textTitle,
                    style: AppStyle.textStyle15
                        .copyWith(color: AppColors.mainColor, fontSize: 18),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image(image: AssetImage(Resources.INFO))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
