import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/screen/mobile_confirmation/mail_confirmation.dart';
import 'package:afsha/screen/regstration_Screen/regstration_Screen.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/src/provider.dart';

import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  bool autoNavigateToLastScreen;
  @override
  _LoginScreenState createState() => _LoginScreenState();

  LoginScreen({this.autoNavigateToLastScreen = false});
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Positioned(
              bottom: 0.0,
              left: 0.0,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                    color: AppColors.binkLiteColor,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(1000))),
              )),
          ListView(
            children: [
              Row(
                children: [
                  Text(
                    'استثمر وقتك معنا',
                    style: AppStyle.textStyle15
                        .copyWith(color: AppColors.mainColor, fontSize: 20),
                  ),
                  Image(
                    image: AssetImage(Resources.INFO),
                  )
                ],
              ),
              Text(
                'أهلاَ بك في قفشة لتوصيل جميع طلباتك',
                style: AppStyle.textStyle15
                    .copyWith(color: AppColors.grayDarkColor),
              ),
              Image(image: AssetImage(Resources.Vectors), height: 296.h),
              Text(
                'تسجيل الدخول',
                style:
                    AppStyle.textStyle15.copyWith(color: AppColors.mainColor),
              ),
              Text(
                'رقم الهاتف',
                style: AppStyle.textStyle12.copyWith(
                  fontFamily: "Cairo",
                ),
              ),
              CustomTextField(
                textInputType: TextInputType.phone,
                controller: _phoneController,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    size: 16,
                  ),
                  color: AppColors.mainColor,
                ),
                hintText: 'أدخل رقم الهاتف',
              ).addPaddingHorizontalVertical(vertical: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EduButton(
                    onPressed: () {

                      context.read<LoginProvider>().formValidationLogin(
                          context: context,
                          phone: _phoneController.text,
                          autoNavigateToLastScreen:
                              widget.autoNavigateToLastScreen);
                    },
                    width: context.width * 0.5,
                    bgColor: MaterialStateProperty.all(AppColors.mainColor),
                    title: 'إرسال الكود',
                    style: AppStyle.textStyle15
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ],
              ).addPaddingHorizontalVertical(vertical: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: new TextSpan(
                        text: 'ليس لديك حساب؟ ',
                        style: AppStyle.textStyle12.copyWith(
                            fontFamily: 'Cairo',
                            color: AppColors.grayDarkColor),
                        children: [
                          new TextSpan(
                            text: 'إنشاء حساب',
                            style: AppStyle.textStyle12
                                .copyWith(fontFamily: 'Cairo'),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () => NavigatorX.push(
                                  context, RegistrationScreen()),
                          )
                        ]),
                  )
                ],
              ).addPaddingHorizontalVertical(vertical: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        NavigatorX.push(context, MainPage(index: 0));
                      },
                      child: Text(
                        'تخطي',
                        style: AppStyle.textStyle15,
                      ).addPaddingOnly(bottom: 30)),
                ],
              ),
            ],
          ).addPaddingHorizontalVertical(horizontal: 16),
        ],
      ),
    );
  }
}
