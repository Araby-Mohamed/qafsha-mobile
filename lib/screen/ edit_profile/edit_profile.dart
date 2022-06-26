import 'dart:io';

import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/extensions/image_picker.dart';
import 'package:afsha/model/profile_response_model.dart';
import 'package:afsha/screen/%20edit_profile/profile_provider.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'change_password_bottom_sheet.dart';
import 'change_phone.dart';

class EditProfile extends StatefulWidget {
  UserProfile userProfile;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  int id = 1;
  String radioButtonItem = 'ONE';

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  ValueNotifier<File> _imageNotifier = ValueNotifier<File>(null);
  String imageUrl;
  void updateProfile() {
    print(' _imageNotifier.value => ${ _imageNotifier.value}');
    context.read<EditProfileProvider>().updateProfileApi(
          context: context,
          email: _emailController.text,
          phone: _phoneController.text,
          image: _imageNotifier.value,
          firstName: _firstNameController.text,
          callBack: () =>
              context.read<EditProfileProvider>().getProfile(context: context),
        );
  }

  UserProfile user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<EditProfileProvider>().getProfile(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<EditProfileProvider>();
    if (user == null) {
      user = provider.userProfileResponseModel;
      _firstNameController = TextEditingController(text: user.username);
      _emailController = TextEditingController(text: user.email);
      _phoneController = TextEditingController(text: user.phone);
      imageUrl = user.image;
      // _imageNotifier.value = user.image;
    }
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'تعديل البيانات الشخصية',
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
      body: provider.getUserProfileLoader
          ? horizontalShimmer(context: context, height: 43, itemCount: 3)
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        'الإسم ',
                        style: AppStyle.textStyle12.copyWith(
                          fontFamily: "Cairo",
                        ),
                      ),
                      CustomTextField(
                        textInputType: TextInputType.name,
                        controller: _firstNameController,
                        prefixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.user,
                            size: 16,
                          ),
                          color: AppColors.mainColor,
                        ),
                        hintText: 'Ahmed Maroof',
                      ).addPaddingHorizontalVertical(vertical: 10),
                      Text(
                        'صورة البروفايل',
                        style: AppStyle.textStyle12.copyWith(
                          fontFamily: "Cairo",
                        ),
                      ),
                      ValueListenableBuilder<File>(
                        valueListenable: _imageNotifier,
                        builder: (BuildContext context, File imagePath, _) =>
                            CustomTextField(
                          readOnly: true,
                          prefixIcon: Image(
                            image: AssetImage(Resources.SURFACE),
                            color: AppColors.mainColor,
                          ),
                          hintText: imagePath != null
                              ? imagePath.path.toString()
                              : imageUrl.isNotEmpty
                                  ? imageUrl
                                  : 'اختر صورة البروفايل',
                          suffixIcon: Container(
                            color: AppColors.binkColor,
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () async {
                                final File file =
                                    await showImagePicker(context);
                                if (file?.path != null) {
                                  _imageNotifier.value = file;
                                }
                              },
                              icon: FaIcon(FontAwesomeIcons.cloudUploadAlt),
                              color: AppColors.mainColor,
                            ),
                          ),
                        ).addPaddingHorizontalVertical(vertical: 10),
                      ),
                      Text(
                        'النوع',
                        style: AppStyle.textStyle12.copyWith(
                          fontFamily: "Cairo",
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Radio(
                              value: 1,
                              groupValue: id,
                              activeColor: AppColors.mainColor,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.mainColor.withOpacity(0.7)),
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'ONE';
                                  id = 1;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.male),
                            color: AppColors.grayDarkColor,
                            padding: EdgeInsets.zero,
                          ),
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Radio(
                              activeColor: AppColors.mainColor,
                              fillColor: MaterialStateProperty.all(
                                  AppColors.mainColor.withOpacity(0.7)),
                              value: 2,
                              groupValue: id,
                              onChanged: (val) {
                                setState(() {
                                  radioButtonItem = 'TWO';
                                  id = 2;
                                });
                              },
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(FontAwesomeIcons.female),
                            color: AppColors.grayDarkColor,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                      Text(
                        'البريد الإلكتروني',
                        style: AppStyle.textStyle12.copyWith(
                          fontFamily: "Cairo",
                        ),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'ادخل البريد الإلكتروني',
                        prefixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.envelope,
                            size: 16,
                          ),
                          color: AppColors.mainColor,
                        ),
                      ).addPaddingHorizontalVertical(vertical: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'رقم الهاتف',
                            style: AppStyle.textStyle12.copyWith(
                              fontFamily: "Cairo",
                            ),
                          ),
                          InkWell(
                            onTap: () => showChangePhoneBottomSheet(context),
                            child: Row(
                              children: [
                                Text(
                                  'تغيير',
                                  style: AppStyle.textStyle12.copyWith(
                                    fontFamily: "Cairo",
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.mainColor,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      CustomTextField(
                        controller: _phoneController,
                        hintText: 'ادخل رقم الهاتف',
                        prefixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.phone,
                            size: 16,
                          ),
                          color: AppColors.mainColor,
                        ),
                        textInputType: TextInputType.phone,
                      ).addPaddingHorizontalVertical(vertical: 10),
                    ],
                  ).addPaddingHorizontalVertical(horizontal: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EduButton(
                      onPressed: () {
                        print('done order');
                        updateProfile();
                      },
                      width: context.width * 0.5,
                      bgColor: MaterialStateProperty.all(AppColors.mainColor),
                      title: 'حفط',
                      style: AppStyle.textStyle15
                          .copyWith(color: AppColors.whiteColor),
                    ),
                  ],
                ).addPaddingOnly(bottom: 30, top: 15),
              ],
            ),
    );
  }
}
