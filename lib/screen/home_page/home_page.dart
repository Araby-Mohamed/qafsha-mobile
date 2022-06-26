import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/ConfirmDialogTwoButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/services_response_model.dart';
import 'package:afsha/screen/%20pick_location/location_provider.dart';
import 'package:afsha/screen/%20pick_location/pick_location.dart';
import 'package:afsha/screen/login_screen/login_screen.dart';
import 'package:afsha/screen/restaurants/restaurants_screen.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  changeSelectedIndex(int newIndex) => selectedIndexNotifier.value = newIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomePageProvider>().getServices(context: context);
    });
  }

  TextEditingController _searchQuery = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var homePageProvider = context.watch<HomePageProvider>();
    var mapProvider = context.watch<LocationProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                if (mapProvider.address == null) {
                  mapProvider.getPermission();
                  return;
                }
                NavigatorX.push(context, PickLocation());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.locationColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Text(mapProvider.address ?? '1حدد موقعك',
                        style: AppStyle.textStyle12.copyWith(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('الخدمات المتاحة',
                    style: AppStyle.textStyle12.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ).addPaddingHorizontalVertical(vertical: 10),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: selectedIndexNotifier,
                  builder: (BuildContext context, int selectedIndex, _) {
                    return gridViewBuilder(homePageProvider);
                  }),
            )
          ],
        ).addPaddingHorizontalVertical(horizontal: 16, vertical: 10),
      ),
    );
  }

  Widget _itemBody(BuildContext context, ServicesDataList servicesDataList, _) {
    return InkWell(
      onTap: () {
        if (sL<SharedPrefService>().isLoggedIn())
          NavigatorX.push(
              context,
              RestaurantsScreen(
                id: servicesDataList.id,
              ));
        else
          /* showDialog(
            context: context,
            builder: (_) => ConfirmDialogTwoButton(
              title: "هام",
              leftButtonText: "موافق",
              onPressLift: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())),
              bgColor: AppColors.mainColor,
              rightButtonText: 'الغاء',
              colorRight: AppColors.binkColor,
              onPress: () => Navigator.pop(context),
              mess: "بالرجاء تسجيل الدخول اولا",
            ),
          );*/
          NavigatorX.push(
              context,
              RestaurantsScreen(
                id: servicesDataList.id,
              ));
      },
      child: Container(
        height: 140.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            gradient: AppColors.gradient,
            color: AppColors.whiteColor,
            boxShadow: AppColors.boxShadow),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 80.h,
                child: cachedNetworkImageXRectangle(
                    imageUrl: servicesDataList.image,
                    context: context,
                    boxFit: BoxFit.cover)),
            Text(
              servicesDataList.title,
              style: AppStyle.textStyle12.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }

  Widget gridViewBuilder(HomePageProvider homePageProvider) {
    return PagewiseGridView<ServicesDataList>.count(
      pageSize: 10,
      shrinkWrap: true,
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      childAspectRatio: context.width / (context.height * .34.h),
      crossAxisCount: 2,
      noItemsFoundBuilder: (context) {
        return Text('No Items Found');
      },
      itemBuilder: this._itemBody,
      pageFuture: (pageIndex) => homePageProvider.getServices(
        context: context,
        pageNumber: pageIndex + 1,
      ),
      loadingBuilder: (BuildContext context) =>
          gridShimmer(context: context, itemCount: 4),
    );
  }
}
