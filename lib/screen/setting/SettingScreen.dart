import 'package:afsha/Components/Style.dart';
import 'package:afsha/model/setting_response_model.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
class StringScreen extends StatefulWidget {
  SettingData settingData;
  @override
  _StringScreenState createState() => _StringScreenState();

  StringScreen({@required this.settingData});
}

class _StringScreenState extends State<StringScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            title: Text(
              widget.settingData?.pageName ?? '',
              style: AppStyle.textStyle15,
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.blackColor,
              ),
            )),
        body: SingleChildScrollView(
          child: Text(
            widget.settingData?.content ?? '',
          ),
        ).addPaddingHorizontalVertical(horizontal: 16));
  }
}
