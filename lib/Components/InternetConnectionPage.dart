import 'package:afsha/Components/Style.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:flutter/material.dart';
class NetworkConnectionMessage extends StatefulWidget {
  @override
  _NetworkConnectionMessageState createState() => _NetworkConnectionMessageState();
}

class _NetworkConnectionMessageState extends State<NetworkConnectionMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/no-wifi.png', color: AppColors.mainColor, width: 200.0, height: 200.0,),
            SizedBox(height: 10,),
            Text(Constants.NETWORK_VALIDATION_TITLE, style: TextStyle(color: Color(0xff777777), fontSize: 30.0
            ),),

            SizedBox(height: 20,),
            Text(Constants.NETWORK_VALIDATION_MESS,textAlign: TextAlign.center, style: TextStyle(color: Color(0xff777777), fontSize: 15.0)),

          ],
        ),
      ),
    );
  }
}
