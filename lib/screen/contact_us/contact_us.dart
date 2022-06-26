import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'contact_us_provider.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: AppColors.blackColor,
              size: 25,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    'تحدث معنا ',
                    style: AppStyle.textStyle15
                        .copyWith(color: AppColors.mainColor),
                  ),
                  Image(image: AssetImage(Resources.INFO))
                ],
              ),
              Text(
                'هنالك العديد من الأنواع المتوفرة لنصوص لوريم إيبسوم، ولكن الغالبية',
                style: AppStyle.textStyle10
                    .copyWith(color: AppColors.grayDarkColor),
              ),
              SizedBox(
                height: 45,
              ),
              Text(
                'الإسم ',
                style: AppStyle.textStyle12.copyWith(
                  fontFamily: "Cairo",
                ),
              ),
              CustomTextField(
                controller: _name,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    size: 16,
                  ),
                  color: AppColors.mainColor,
                ),
                hintText: 'اكتب اسمك للتواصل',
              ).addPaddingHorizontalVertical(vertical: 10),
              Text(
                'البريد الإلكتروني ',
                style: AppStyle.textStyle12.copyWith(
                  fontFamily: "Cairo",
                ),
              ),
              CustomTextField(
                controller: _email,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    size: 16,
                  ),
                  color: AppColors.mainColor,
                ),
                hintText: 'اكتب البريد الإلكتروني',
              ).addPaddingHorizontalVertical(vertical: 10),
              Text(
                'رقم الهاتف ',
                style: AppStyle.textStyle12.copyWith(
                  fontFamily: "Cairo",
                ),
              ),
              CustomTextField(
                controller: _phone,
                textInputType: TextInputType.phone,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    size: 16,
                  ),
                  color: AppColors.mainColor,
                ),
                hintText: 'اكتب ارقم الهاتف الحالي',
              ).addPaddingHorizontalVertical(vertical: 10),
              Text(
                'العنوان ',
                style: AppStyle.textStyle12.copyWith(
                  fontFamily: "Cairo",
                ),
              ),
              CustomTextField(
                controller: _address,
                prefixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    size: 16,
                  ),
                  color: AppColors.mainColor,
                ),
                hintText: 'اكتب عنوان الرسالة',
              ).addPaddingHorizontalVertical(vertical: 10),
              Text(
                'الرسالة ',
                style: AppStyle.textStyle12.copyWith(
                  fontFamily: "Cairo",
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                        color: AppColors.mainColor.withOpacity(0.2))),
                child: TextFormField(
                    maxLines: 4,
                    controller: _message,
                    decoration: new InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        hintText: 'اكتب رسالتك',
                        border: InputBorder.none,
                        hintStyle: AppStyle.textStyle12
                            .copyWith(color: AppColors.grayDarkColor))),
              ).addPaddingHorizontalVertical(vertical: 10)
            ],
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EduButton(
                onPressed: () {
                  print('done order');
                  context.read<ContactUsProvider>().contactApi(
                      context: context,
                      email: _email.text,
                      message: _message.text,
                      name: _name.text,
                      phone: _phone.text,
                      subject: _address.text);
                  //  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderConfirmation()));
                },
                width: context.width * 0.9,
                bgColor: MaterialStateProperty.all(AppColors.mainColor),
                title: 'إرسال  الرسالة',
                style:
                    AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
              ),
            ],
          ).addPaddingOnly(
            bottom: 30,
          ),
        ],
      ).addPaddingHorizontalVertical(horizontal: 16),
    );
  }
}
