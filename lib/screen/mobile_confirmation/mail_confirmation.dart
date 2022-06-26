import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/login_screen/login_provider.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:provider/src/provider.dart';
import 'background_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'mail_confirmation_provider.dart';

class MailConfirmation extends StatefulWidget {
  bool autoNavigateToLastScreen;
  final String phone;
  @override
  _MailConfirmationState createState() => _MailConfirmationState();

  MailConfirmation(
      {this.autoNavigateToLastScreen = false, @required this.phone});
}

class _MailConfirmationState extends State<MailConfirmation> {
  var _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BackGroundScreen(
            title: "تأكيد رقم الهاتف",
            subTitle:
                "هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء لصفحة",
            pageForm: _mailConfirmationForm()),
      ),
    );
  }

  Widget _mailConfirmationForm() {
    return Column(
      children: [
        SvgPicture.asset(
          Resources.Confirmation,
          height: 300.h,
        ),
        SizedBox(height: 25.h),
        _buildCodeTextFiled(),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EduButton(
              onPressed: () {
                print('done order');
                context.read<MailConfirmationProvider>().mailConfirmationApi(
                    context: context,
                    verifyCode: _codeController.text,
                    autoNavigateToLastScreen: widget.autoNavigateToLastScreen,
                    callBack: () => NavigatorX.push(
                        context,
                        MainPage(
                          index: 0,
                        )));
              },
              width: context.width * 0.9,
              bgColor: MaterialStateProperty.all(AppColors.mainColor),
              title: 'تأكيد رقم الهاتف',
              style: AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
            ),
          ],
        ).addPaddingHorizontalVertical(horizontal: 16),
        customRichText(
                firstText: 'لم يصلني كود ',
                firstTextStyle: AppStyle.textStyle10
                    .copyWith(color: AppColors.grayDarkColor),
                secondText: 'إرسال مرة أخري',
                secondTextStyle:
                    AppStyle.textStyle10.copyWith(color: AppColors.blackColor),
                onSecondTextTapped: () => context
                    .read<LoginProvider>()
                    .loginApi(context: context, phone: widget.phone, withNavigate: false),
                context: context)
            .addPaddingHorizontalVertical(vertical: 20),
      ],
    );
  }

  Widget _buildCodeTextFiled() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Form(
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                controller: _codeController,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  activeColor: AppColors.binkLite2Color,
                  disabledColor: AppColors.binkLite2Color,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 37,
                  fieldWidth: 42,
                  inactiveColor: AppColors.binkLite2Color,
                  selectedColor: AppColors.binkLite2Color,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: AppColors.binkLite2Color,
                  activeFillColor: AppColors.binkLite2Color,
                ),
                cursorColor: AppColors.mainColor,
                animationDuration: Duration(milliseconds: 300),
                textStyle: AppStyle.textStyle15,
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                // controller: pinController,
                keyboardType: TextInputType.number,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    //   code = value;
                  });
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
              ))),
    );
  }
}
