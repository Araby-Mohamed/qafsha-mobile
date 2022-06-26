import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/Widget/custom_app_bar.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/utils/navigatorX.dart';
import '../../model/store/store_response_model.dart';
import 'package:afsha/screen/restaurant_details/restaurant_details.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'restaurants_provider.dart';

class RestaurantsScreen extends StatefulWidget {
  final int id;
  RestaurantsScreen({this.id});

  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  TextEditingController _searchQuery = TextEditingController();

  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);
  ValueNotifier<bool> displaySearchResultNotifier = ValueNotifier<bool>(false);
  changeSelectedIndex(int newIndex) => selectedIndexNotifier.value = newIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<RestaurantsProvider>()
          .getStore(context: context, idServices: widget.id, pageNumber: 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    var restaurantsProvider = context.watch<RestaurantsProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'المطاعم المتاحة',
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
      body: ValueListenableBuilder(
        valueListenable: displaySearchResultNotifier,
        builder: (BuildContext context, bool showSearch, _) => Column(
          children: [
            Container(
              color: AppColors.whiteColor,
              child: CustomTextField(
                onFieldSubmitted: (value) {
                  print("value => $value");
                  restaurantsProvider.getSearch(
                      context: context, title: value, pageNumber: 1);
                },
                onChanged: (String text) {
                  if (text.isNotEmpty) {
                    restaurantsProvider.setSearchResultStoreList =
                        <StoreDataList>[];
                    restaurantsProvider.setStartSearch = false;
                    displaySearchResultNotifier.value = true;
                    return;
                  }
                  displaySearchResultNotifier.value = false;
                },
                controller: _searchQuery,
                maxLines: 1,
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: AppColors.mainColor.withOpacity(0.5),
                  size: 30,
                ),
                hintText: 'عن ماذا تبحث؟',
                suffixIcon: InkWell(
                  onTap: () {
                    _searchQuery.clear();
                    restaurantsProvider.setStartSearch = false;
                    displaySearchResultNotifier.value = false;
                  },
                  child: SvgPicture.asset(
                    Resources.CLOSE,
                    color: AppColors.mainColor.withOpacity(0.5),
                  ).addPaddingAll(13),
                ),
              ).addPaddingHorizontalVertical(vertical: 10),
            ),
            Expanded(
                child: showSearch
                    ? searchResult()
                    : listViewBuilder(restaurantsProvider))
          ],
        ).addPaddingHorizontalVertical(horizontal: 16),
      ),
    );
  }

  Widget _restaurantsItem(
      BuildContext context, StoreDataList storeDataList, _) {
    return InkWell(
      onTap: () => NavigatorX.push(
          context,
          RestaurantDetails(
            idRestaurant: storeDataList.id,
          )),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: AppColors.boxShadow,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(gradient: AppColors.gradient),
                child: cachedNetworkImageX(
                    imageUrl: storeDataList.logo, boxFit: BoxFit.cover),
                height: 50.h,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 3,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      storeDataList.name,
                      style: AppStyle.textStyle12.copyWith(fontFamily: "Cairo"),
                    ),
                    Row(
                      children: [
                        ...storeDataList.departments.map((e) {
                          bool isLastIndex =
                              storeDataList.departments.indexOf(e) ==
                                  storeDataList.departments.length - 1;
                          return Row(
                            children: [
                              Text(
                                e.title,
                                style: AppStyle.textStyle10
                                    .copyWith(color: AppColors.blackColor),
                              ).addPaddingHorizontalVertical(horizontal: 1),
                              if (!isLastIndex)
                                Icon(
                                  Icons.remove,
                                  size: 10,
                                )
                            ],
                          );
                        })
                      ],
                    ),
                  ],
                )),
            Expanded(
                flex: 3,
                child: FittedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.star,
                        color: AppColors.yellowColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '4.0',
                        style: AppStyle.textStyle10
                            .copyWith(color: AppColors.blackColor),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        height: 20,
                        width: 1,
                        color: AppColors.mainColor.withOpacity(.3),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.directions_car_rounded,
                        color: AppColors.mainColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        storeDataList.distance,
                        style: AppStyle.textStyle10
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  ).addPaddingOnly(left: 5),
                )),
          ],
        ),
      ).addPaddingHorizontalVertical(
        vertical: 7,
      ),
    );
  }

  Widget searchResult() {
    Widget widget = Text('ادخال كلمه البحث');
    var provider = context.read<RestaurantsProvider>();
    if (provider.startSearch) {
      if ((provider?.searchResultStoreList?.length ?? 0) > 0) {
        return widget = ListView(
          shrinkWrap: true,
          children: provider.searchResultStoreList
              .map((e) => _restaurantsItem(context, e, null))
              .toList(),
        );
      } else {
        widget = Text('لا توجد نتائج لهذا البحث');
      }
    }

    return widget;
  }

  Widget listViewBuilder(RestaurantsProvider restaurantsProvider) {
    return PagewiseListView<StoreDataList>(
        pageSize: 10,
        shrinkWrap: true,
        itemBuilder: this._restaurantsItem,
        noItemsFoundBuilder: (context) {
          return Text('No Items Found');
        },
        pageFuture: (pageIndex) => restaurantsProvider.getStore(
            context: context, pageNumber: pageIndex + 1, idServices: widget.id),
        loadingBuilder: (BuildContext context) =>
            horizontalShimmer(context: context));
  }

  Widget listViewSearchResultBuilder(
      RestaurantsProvider restaurantsProvider, String searchQuery) {
    return PagewiseListView<StoreDataList>(
        pageSize: 10,
        shrinkWrap: true,
        itemBuilder: this._restaurantsItem,
        noItemsFoundBuilder: (context) {
          return Text('No Items Found');
        },
        pageFuture: (pageIndex) => restaurantsProvider.getSearch(
            context: context, pageNumber: pageIndex + 1, title: searchQuery),
        loadingBuilder: (BuildContext context) =>
            horizontalShimmer(context: context, itemCount: 4));
  }
}
