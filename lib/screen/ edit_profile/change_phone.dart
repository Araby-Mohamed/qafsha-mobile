import 'package:afsha/screen/%20edit_profile/edit_profile.dart';
import 'package:afsha/screen/mobile_confirmation/mail_confirmation_provider.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../../Components/Style.dart';
import '../../Components/Widget/EduButton.dart';
import '../../Components/Widget/ProfilePageTextFileds.dart';
import '../../tools/AppColors.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextEditingController _changePhoneController = TextEditingController();
var _codeController = TextEditingController();
ValueNotifier<bool> showFormNotifier = ValueNotifier<bool>(false);
Widget textFieldWidget = CustomTextField(
  controller: _changePhoneController,
  textInputType: TextInputType.phone,
  prefixIcon: Icon(
    Icons.phone,
    color: AppColors.mainColor,
    size: 22,
  ),
  hintText: 'اكتب رقم الهاتف',
).addPaddingHorizontalVertical(vertical: 10);

Future<void> showChangePhoneBottomSheet(
  BuildContext context,
) async {
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
              height: 350.h,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: ValueListenableBuilder(
                valueListenable: showFormNotifier,
                builder: (BuildContext context, bool showForm, _) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30.h,
                      ),
                      Container(
                        width: 45,
                        height: 3,
                        decoration: BoxDecoration(
                            color: Color(0xff9FA1B5),
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "تغيير رقم الهاتف",
                            style: AppStyle.textStyle15,
                          ),
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.close))
                        ],
                      ).addPaddingHorizontalVertical(vertical: 10),
                      Divider(),
                      AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: showForm == false
                            ? textFieldWidget
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('اكتب الكود'),
                                    ],
                                  ),
                                  _buildCodeTextFiled(context),
                                ],
                              ),
                      ),
                      EduButton(
                        onPressed: () {
                          showFormNotifier.value = !showForm;
                          showForm == true
                              ? context
                                  .read<MailConfirmationProvider>()
                                  .mailConfirmationApi(
                                      context: context,
                                      verifyCode: _codeController.text,
                                      callBack: () => NavigatorX.push(
                                          context, EditProfile()))
                              : print('scened step');
                        },
                        width: context.width,
                        bgColor: MaterialStateProperty.all(AppColors.mainColor),
                        title: showForm == true ? 'إرسال الكود' : 'التالي',
                        style: AppStyle.textStyle15
                            .copyWith(color: AppColors.whiteColor),
                      ).addPaddingHorizontalVertical(vertical: 15),
                    ],
                  ).addPaddingHorizontalVertical(horizontal: 16);
                },
              )),
        );
      });
}

Widget _buildCodeTextFiled(BuildContext context) {
  return Form(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
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
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              return true;
            },
          )));
}
