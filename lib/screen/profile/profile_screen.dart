import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/%20edit_profile/edit_profile.dart';
import 'package:afsha/screen/%20edit_profile/profile_provider.dart';
import 'package:afsha/screen/contact_us/contact_us.dart';
import 'package:afsha/screen/login_screen/login_provider.dart';
import 'package:afsha/screen/setting/SettingScreen.dart';
import 'package:afsha/screen/setting/setting_provider.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:collection/collection.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EditProfileProvider>().getProfile(context: context);
      context.read<SettingProvider>().getSettingApi(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<EditProfileProvider>();
    var settingProvider = context.watch<SettingProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        automaticallyImplyLeading: false,
        title: Text(
          'الحساب الشخصي',
          style: AppStyle.textStyle15.copyWith(fontSize: 23),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: AppColors.gradient,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.binkColor)),
                child: cachedNetworkImageXCir(
                    imageUrl: provider?.userProfileResponseModel?.image ??
                        Constants.IMAGE_PLACE_HOLDER,
                    boxFit: BoxFit.cover),
                height: 100.r,
                width: 100.r,
              ).shimmerWhenLoading(provider.getUserProfileLoader),
              SizedBox(
                height: 10,
              ),
              Text(
                provider?.userProfileResponseModel?.username ?? 'اسم المستخدم',
                style: AppStyle.textStyle12.copyWith(fontSize: 19),
              ).shimmerWhenLoading(provider.getUserProfileLoader)
            ],
          ).addPaddingHorizontalVertical(vertical: 10),
          Divider(
            color: AppColors.mainColor.withOpacity(0.5),
          ),
          Text(
            'إعدادات الحساب',
            style: AppStyle.textStyle15
                .copyWith(fontSize: 23, color: AppColors.grayDarkColor),
          ).addPaddingOnly(bottom: 10, top: 10),
          rowBuild(
              name: 'البيانات الشخصية',
              image: Resources.IMAGE1,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()))),
          rowBuild(
                  name: "سياسة الاستخدام",
                  image: Resources.IMAGE2,
                  onTap: settingProvider.getStringLoader
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StringScreen(
                                    settingData:
                                        settingProvider.settingData.firstOrNull,
                                  ))))
              .shimmerWhenLoading(settingProvider.getStringLoader),
          rowBuild(
              name: 'تحدث معنا',
              image: Resources.IMAGE3,
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUs()))),
          rowBuild(
                  name: 'الشروط والأحكام',
                  image: Resources.IMAGE4,
                  onTap: settingProvider.getStringLoader
                      ? null
                      : () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => StringScreen(
                                    settingData: settingProvider.settingData[1],
                                  ))))
              .shimmerWhenLoading(settingProvider.getStringLoader),
          rowBuild(
              name: 'تسجيل الخروج',
              image: Resources.IMAGE5,
              onTap: () {context.read<LoginProvider>().logOutApi(context: context);
              }),
        ],
      ).addPaddingHorizontalVertical(horizontal: 16),
    );
  }

  Widget rowBuild({String name, GestureTapCallback onTap, String image}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppStyle.textStyle15,
              ),
              SvgPicture.asset(image)
            ],
          ).addPaddingHorizontalVertical(vertical: 10),
        ),
        Divider(),
      ],
    );
  }
}
