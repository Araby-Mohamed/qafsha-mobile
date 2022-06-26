import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/ConfirmDialogTwoButton.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/screen/login_screen/login_screen.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'restaurant_details_provider.dart';
import 'package:provider/provider.dart';

ValueNotifier<int> orderStatusNotifier = ValueNotifier<int>(0);
Future<void> restaurantOrderAdditions(
    BuildContext context, int productId, int counter) async {
  var provider = context.read<RestaurantsDetailsProvider>();
  provider.getProduct(context: context, productId: productId);
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    provider.setCounter = counter;
  });
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColors.mainColor;
    }
    return AppColors.mainColor;
  }

  await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
      ),
      builder: (builder) {
        return Consumer<RestaurantsDetailsProvider>(
            builder: (BuildContext context, provider, _) {
          return Container(
              height: context.height * 0.9,
              child: provider.productStoreDetailsLoader == true
                  ? Center(child: CupertinoActivityIndicator())
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider?.productStoreDetailsData?.title ??
                                  'لا يوجد',
                              style: AppStyle.textStyle15,
                            ),
                            IconButton(
                                onPressed: () {
                                  provider.resetCounter();
                                  provider.resetCalculatePrice(provider
                                      ?.productStoreDetailsData?.price
                                      ?.toDouble());
                                  Navigator.pop(context);
                                },
                                // onPressed: () => Navigator.pop(context),
                                icon: Icon(Icons.close))
                          ],
                        ).addPaddingHorizontalVertical(
                            horizontal: 16, vertical: 10),
                        Expanded(
                            child: ListView(
                          children: [
                            Container(
                              height: 150,
                              decoration:
                                  BoxDecoration(gradient: AppColors.gradient),
                              child: cachedNetworkImageX(
                                  imageUrl:
                                      provider?.productStoreDetailsData?.image,
                                  boxFit: BoxFit.cover),
                            ),
                            Divider(
                              color: AppColors.mainColor,
                              height: 0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'مكونات الوجبة',
                                  style: AppStyle.textStyle15
                                      .copyWith(color: AppColors.mainColor),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    width: context.width * 0.6,
                                    child: Text(
                                      provider?.productStoreDetailsData
                                              ?.description ??
                                          'لا يوجد',
                                      style: AppStyle.textStyle12.copyWith(
                                          color: AppColors.blackColor),
                                    )),
                              ],
                            ).addPaddingHorizontalVertical(
                                horizontal: 16, vertical: 10),
                            ListTileTheme(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 13),
                              dense: true,
                              child: ExpansionTile(
                                initiallyExpanded: true,
                                textColor: AppColors.blackColor,
                                iconColor: AppColors.blackColor,
                                title: Text(
                                  'اختر من',
                                  style: AppStyle.textStyle12,
                                ),
                                children: [
                                  ...provider.productStoreDetailsData.additions
                                      .map((item) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Checkbox(
                                              checkColor: Colors.white,
                                              fillColor: MaterialStateProperty
                                                  .resolveWith(getColor),
                                              value: provider.checkBoxAdditions
                                                  .contains(item),
                                              onChanged: (bool value) {
                                                if (provider.checkBoxAdditions
                                                    .contains(item)) {
                                                  provider.removeItem(item);
                                                  return;
                                                }
                                                provider.addNewItem(item);
                                              },
                                            ),
                                            Text(
                                              item.title ?? ' لايوجد',
                                              style: AppStyle.textStyle12
                                                  .copyWith(
                                                      color:
                                                          AppColors.blackColor),
                                            ),
                                          ],
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: item.price ??
                                                provider.productStoreDetailsData
                                                    .price,
                                            style: AppStyle.textStyle12
                                                .copyWith(
                                                    color: AppColors.mainColor),
                                            children: const <TextSpan>[
                                              TextSpan(
                                                  text: ' ريال.س ',
                                                  style: TextStyle(
                                                      color: AppColors
                                                          .blackColor)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                                ],
                              ),
                            )
                          ],
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          color: AppColors.mainColor
                                              .withOpacity(0.5),
                                        )),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () => provider.increment(
                                              provider?.productStoreDetailsData
                                                  ?.price
                                                  ?.toDouble()),
                                          icon: Icon(
                                            Icons.add,
                                            size: 18,
                                            color: AppColors.mainColor,
                                          ),
                                        )),
                                    Text('${provider.count}',
                                            style: AppStyle.textStyle12.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ))
                                        .addPaddingHorizontalVertical(
                                            horizontal: 15),
                                    Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                          color: AppColors.mainColor
                                              .withOpacity(0.5),
                                        )),
                                        child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (provider.count == 1) {
                                              showToast(
                                                  message:
                                                      "عفوا هذه اقل كميه يمكنك طلبها شكرا لك ..");
                                              return;
                                            }
                                            provider.decrement(provider?.productStoreDetailsData?.price?.toDouble());
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                            size: 18,
                                            color: AppColors.mainColor,
                                          ),
                                        )),
                                  ],
                                ),
                                Text(
                                  "${provider.calculatedPrice ?? provider.defaultPrice(provider?.productStoreDetailsData?.price?.toDouble())}  ريال. س ",
                                  style: AppStyle.textStyle15
                                      .copyWith(color: AppColors.mainColor),
                                ).addPaddingHorizontalVertical(vertical: 5),
                                EduButton(
                                  onPressed: () {
                                    if (!sL<SharedPrefService>().isLoggedIn()) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => ConfirmDialogTwoButton(
                                          title: "هام",
                                          leftButtonText: "تسجيل",
                                          onPressLift: () => NavigatorX.push(
                                              context,
                                              LoginScreen(
                                                autoNavigateToLastScreen: true,
                                              )),
                                          bgColor: AppColors.mainColor,
                                          rightButtonText: 'الغاء',
                                          colorRight: AppColors.binkColor,
                                          onPress: () => Navigator.pop(context),
                                          mess: "بالرجاء تسجيل الدخول اولا",
                                        ),
                                      );
                                      return;
                                    }
                                    orderStatusNotifier.value = 1;
                                    provider.setCartApi(
                                        context: context,
                                        quantity: provider.count.toString(),
                                        productId: provider
                                            .productStoreDetailsData.id
                                            .toString(),
                                        onSuccess: () {
                                          provider.resetCounter();
                                          provider.resetCalculatePrice(provider
                                              ?.productStoreDetailsData?.price
                                              ?.toDouble());
                                        });
                                  },
                                  width: context.width * 0.5,
                                  bgColor: MaterialStateProperty.all(
                                      AppColors.mainColor),
                                  title: 'إضافة الطلب',
                                  style: AppStyle.textStyle15
                                      .copyWith(color: AppColors.whiteColor),
                                ),
                              ],
                            ),
                          ],
                        ).addPaddingHorizontalVertical(vertical: 9)
                      ],
                    ));
        });
      });
}
