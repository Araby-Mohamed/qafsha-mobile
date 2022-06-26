
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/tools/AppColors.dart';

class CustomCircularLoad extends StatelessWidget {
 final String loadingMess;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Material(
        color: Colors.black26,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: GestureDetector(
              onTap: () {
                print('tapped');
              },
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(strokeWidth: 1, backgroundColor: AppColors.whiteColor,),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Text(loadingMess ?? '', style: TextStyle(color: Colors.white),),
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }

 CustomCircularLoad({this.loadingMess});
}