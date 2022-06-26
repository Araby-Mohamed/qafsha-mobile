import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Components/Style.dart';
import '../../Components/Widget/EduButton.dart';
import '../../Components/Widget/ProfilePageTextFileds.dart';
import '../../tools/AppColors.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Future<void> showChangePasswordBottomSheet(BuildContext context) async {
  final _formKey = GlobalKey<FormState>();
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: 350.h,
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
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
                      "تغيير كلمة السر",
                      style: AppStyle.textStyle15,
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close))
                  ],
                ).addPaddingHorizontalVertical(vertical: 10),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'كلمة السر الحالية',
                      style: AppStyle.textStyle12.copyWith(
                        fontFamily: "Cairo",
                      ),
                    )
                  ],
                ),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.mainColor,
                    size: 22,
                  ),
                  hintText: 'اكتب كلمة السر الحالية',
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.mainColor,
                    size: 22,
                  ),
                ).addPaddingHorizontalVertical(vertical: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'كلمة السر الجديدة',
                      style: AppStyle.textStyle12.copyWith(
                        fontFamily: "Cairo",
                      ),
                    )
                  ],
                ),
                CustomTextField(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: AppColors.mainColor,
                    size: 22,
                  ),
                  hintText: 'اكتب كلمة السر الجديدة',
                  suffixIcon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: AppColors.mainColor,
                    size: 22,
                  ),
                ).addPaddingHorizontalVertical(vertical: 10),
                EduButton(
                  onPressed: () {
                    print('done order');
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderConfirmation()));
                  },
                  width: context.width,
                  bgColor: MaterialStateProperty.all(AppColors.mainColor),
                  title: 'تغيير كلمة السر',
                  style:
                  AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
                ).addPaddingHorizontalVertical( vertical: 15),
              ],
            ).addPaddingHorizontalVertical(horizontal: 16),
          ),
        );
      });
}
