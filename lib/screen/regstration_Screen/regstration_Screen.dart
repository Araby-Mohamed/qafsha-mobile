import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/screen/mobile_confirmation/mail_confirmation.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'registration_provider.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
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
                    'إنشاء حساب جديد ',
                    style: AppStyle.textStyle15
                        .copyWith(color: AppColors.mainColor, fontSize: 20),
                  ),
                  Image(image: AssetImage(Resources.INFO),)
                ],
              ),
              Text(
                'أهلاَ بك في قفشة لتوصيل جميع طلباتك',
                style: AppStyle.textStyle15
                    .copyWith(color: AppColors.grayDarkColor),
              ),
              Text('الاسم', style: AppStyle.textStyle12.copyWith(fontFamily: "Cairo",),),
              CustomTextField(
                controller: _userNameController,
                textInputType: TextInputType.name,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.user, size: 16,),
                  color: AppColors.mainColor,
                ),
                hintText: 'اسم المستخدم',
              ).addPaddingHorizontalVertical(vertical: 10),
              Text('البريد الإلكتروني', style: AppStyle.textStyle12.copyWith(fontFamily: "Cairo",),),
              CustomTextField(
                textInputType: TextInputType.emailAddress,
                controller: _emailController,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.envelope, size: 16,),
                  color: AppColors.mainColor,
                ),
                hintText: 'البريد الإلكتروني',
              ).addPaddingHorizontalVertical(vertical: 10),
              Text('رقم الهاتف', style: AppStyle.textStyle12.copyWith(fontFamily: "Cairo",),),
              CustomTextField(
                textInputType: TextInputType.phone,
                controller: _phoneController,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.phone, size: 16,),
                  color: AppColors.mainColor,
                ),
                hintText: 'ادخل رقم الهاتف',
              ).addPaddingHorizontalVertical(vertical: 10),
              Transform.translate(
                offset: const Offset(15.0, 00),
                child: Container(
                  child: Row(
                    children: [
                      ChangeNotifierProvider<RegistrationProvider>(
                        create: (context) => RegistrationProvider(),
                        child: Consumer<RegistrationProvider>(
                          builder: (context, loginprovider, child) =>
                              Checkbox(
                                value: loginprovider.remember,
                                fillColor: MaterialStateProperty.all(AppColors.mainColor),
                                onChanged: (value) {
                                  loginprovider.changeRemember(value);
                                },
                              ),
                        ),
                      ),
                      const Text("أوافق علي "),
                      const Text(
                        "الشروط والسياسة ",
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EduButton(
                    onPressed: () {
                      print('done order');
                      context.read<RegistrationProvider>().formValidationRegistration(context: context,phone: _phoneController.text,email: _emailController.text,username: _userNameController.text,gender: "male");
                    },
                    width: context.width * 0.8,
                    bgColor: MaterialStateProperty.all(AppColors.mainColor),
                    title: 'إنشاء الحساب',
                    style:
                    AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
                  ),
                ],
              ).addPaddingHorizontalVertical(vertical: 25),
            ],
          ).addPaddingHorizontalVertical(horizontal: 16),
        ],
      ),
    );
  }
}