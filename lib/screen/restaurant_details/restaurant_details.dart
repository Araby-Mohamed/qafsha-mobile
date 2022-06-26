import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/store/departments_response_model.dart';
import 'package:afsha/model/store/product_and_fast_food_response_model.dart';
import 'package:afsha/screen/order_confirmation/order_confirmation.dart';
import 'package:afsha/screen/order_confirmation/order_confirmation_provider.dart';
import 'package:afsha/screen/restaurant_details/restaurant_order_additions.dart';
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
import '../../Components/Widget/resturant_info_widget.dart';
import 'restaurant_details_provider.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'package:collection/collection.dart';

class RestaurantDetails extends StatefulWidget {
  final int idRestaurant;
  RestaurantDetails({this.idRestaurant});
  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails>
    with AutomaticKeepAliveClientMixin<RestaurantDetails> {
  ValueNotifier<int> selectedDepartmentIdNotifier = ValueNotifier<int>(0);

  @override
  bool get wantKeepAlive => true;

  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    //   selectedDepartmentIdNotifier.value = widget.idRestaurant;
    NavigatorX.restaurantId = widget.idRestaurant;
    // TODO: implement initState
    super.initState();
    var restaurantsProvider = context.read<RestaurantsDetailsProvider>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      restaurantsProvider.resetPageNo();
      restaurantsProvider.setProductFastFoodList = <ProductAndFastFoodData>[];
      restaurantsProvider.getStore(
        context: context,
        restaurantId: widget.idRestaurant,
      );
      restaurantsProvider.getStoreDepartment(
        context: context,
        storeId: widget.idRestaurant,
      );
    });

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        restaurantsProvider.incrementPageNo();
        restaurantsProvider.getProductAndFastFood(
          context: context,
        );
      }
    });
  }

  DepartmentsDataList departmentsDataList = DepartmentsDataList();
  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

  final PageController _pageController = PageController(initialPage: 0);
  changeSelectedIndex(int newIndex) => selectedIndexNotifier.value = newIndex;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var provider = context.watch<RestaurantsDetailsProvider>();

    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: provider.storeDetailsLoader == true
            ? Center(child: CupertinoActivityIndicator())
            : SafeArea(
                child: Column(children: <Widget>[
                RestaurantInfoContainer(provider: provider),
                provider.storeDepartmentLoader
                    ? CupertinoActivityIndicator()
                    : provider.storeDepartmentData?.length == 0
                        ? Text('لا يوجد')
                        : SizedBox(
                            height: 60.h,
                            child: ListView(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                children: departmentIndicator(
                                    provider.storeDepartmentData, provider))),
                Expanded(
                    child: ListView(
                  controller: _scrollController,
                  children: [
                    ...provider.productFastFoodLoader
                        ? [horizontalShimmer(context: context)]
                        : provider.productFastFoodList.length == 0
                            ? [Text('لا توجد بيانات').setCenter()]
                            : List.generate(
                                1,
                                (_) => Column(
                                      children: provider.productFastFoodList
                                          .map((e) => restaurantsItem(e))
                                          .toList(),
                                    ))
                  ],
                )),
                if (provider.getMoreData) ...{
                  SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                },
                Consumer<RestaurantsDetailsProvider>(
                  builder: (BuildContext context, restaurantProvider, _) {
                    return restaurantProvider.continueOrder == false
                        ? Container(
                            width: context.width,
                            decoration: BoxDecoration(
                              color: AppColors.binkColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'اختر طلبك من المنيو أولاَ',
                                style: AppStyle.textStyle15,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              /* Container(
                                width: context.width,
                                decoration: BoxDecoration(
                                  color: AppColors.binkColor,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'المجموع',
                                        style: AppStyle.textStyle15,
                                      ),
                                      Text(
                                        ' 110.00 ' + ' ' + ' ريال.س ',
                                        style: AppStyle.textStyle15.copyWith(
                                            color: AppColors.mainColor),
                                      ),
                                    ],
                                  ),
                                ),
                              ),*/
                              EduButton(
                                onPressed: () {
                                  print('done order');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderConfirmation()));
                                },
                                width: context.width,
                                bgColor: MaterialStateProperty.all(
                                    AppColors.mainColor),
                                title: 'أكمل الطلب',
                                style: AppStyle.textStyle15
                                    .copyWith(color: AppColors.whiteColor),
                              ),
                            ],
                          );
                  },
                )
              ])));
  }

  ValueNotifier<int> _selectedIndex = ValueNotifier<int>(0);
  List<Widget> departmentIndicator(
      List<DepartmentsDataList> depList, RestaurantsDetailsProvider provider) {
    List<Widget> list = [];
    if (depList != [] || depList != null) {
      for (int i = 0; i < depList?.length; i++) {
        String title = depList[i].title;
        int itemId = depList[i].id;

        list.add(GestureDetector(
            onTap: () {
              provider.resetPageNo();
              provider.getProductAndFastFood(
                context: context,
                storeDepartmentId: itemId,
                storeId: widget.idRestaurant,
              );
              _selectedIndex.value = i;
            },
            child: itemBuilder(index: i, title: title)));
      }
    }
    return list;
  }

  Widget itemBuilder({@required int index, @required String title}) {
    return ValueListenableBuilder(
        valueListenable: _selectedIndex,
        builder: (BuildContext context, int selectedIndex, _) {
          bool selected = selectedIndex == index;
          return AnimatedContainer(
            duration: Duration(milliseconds: 150),
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            child: Text(
              title,
              style: TextStyle(
                  color: selected ? Colors.white : AppColors.blackColor),
            ).setCenter(),
            decoration: BoxDecoration(
              color: selected ? AppColors.mainColor : AppColors.binkColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          );
        });
  }

  Widget restaurantsItem(ProductAndFastFoodData productAndFastFoodData) {
    ValueNotifier<int> _productCounterNotifier =
        ValueNotifier<int>(productAndFastFoodData.counter);
    return InkWell(
      child: ValueListenableBuilder(
        valueListenable: _productCounterNotifier,
        builder: (BuildContext context, int counter, _) => Container(
          decoration: BoxDecoration(
              color: AppColors.whiteColor, boxShadow: AppColors.boxShadow),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: 80.h,
                  decoration: BoxDecoration(gradient: AppColors.gradient),
                  child: cachedNetworkImageX(
                      imageUrl: productAndFastFoodData.image,
                      boxFit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                  flex: 3,
                  child: GestureDetector(
                    onTap: () {
                      restaurantOrderAdditions(
                          context, productAndFastFoodData.id, counter);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productAndFastFoodData.title,
                          style: AppStyle.textStyle12
                              .copyWith(fontFamily: "Cairo"),
                        ),
                        Row(
                          children: [
                            Text(
                              'اختر مكونات الوجبة ',
                              style:
                                  AppStyle.textStyle10.copyWith(fontSize: 10),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 12,
                              color: AppColors.mainColor,
                            ),
                          ],
                        ).addPaddingHorizontalVertical(vertical: 3),
                        Row(
                          children: [
                            Text(
                              productAndFastFoodData.price,
                              style:
                                  AppStyle.textStyle10.copyWith(fontSize: 10),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'ريال سعودي',
                              style: AppStyle.textStyle10.copyWith(
                                  fontSize: 10, color: AppColors.blackColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: AppColors.mainColor.withOpacity(0.5),
                        )),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            _productCounterNotifier.value = counter + 1;
                          },
                          icon: Icon(
                            Icons.add,
                            size: 15,
                            color: AppColors.mainColor,
                          ),
                        )),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: Text(
                        counter.toString(),
                        style: AppStyle.textStyle12.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: AppColors.mainColor.withOpacity(0.5),
                        )),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (counter == 1) {
                              showToast(
                                  message:
                                      "عفوا هذه اقل كميه يمكنك طلبها شكرا لك ..");
                              return;
                            }
                            _productCounterNotifier.value = counter - 1;
                          },
                          icon: Icon(
                            Icons.remove,
                            size: 15,
                            color: AppColors.mainColor,
                          ),
                        )),
                  ],
                ).addPaddingOnly(left: 15, bottom: 10, top: 10),
              ),
            ],
          ),
        ).addPaddingHorizontalVertical(vertical: 7),
      ),
    );
  }

  // Widget listViewBuilder(
  //     RestaurantsDetailsProvider restaurantsDetailsProvider) {
  //   return ValueListenableBuilder(
  //     valueListenable: selectedDepartmentIdNotifier,
  //     builder: (BuildContext context, int departId, _) {
  //       return PagewiseListView<ProductAndFastFoodData>(
  //           pageSize: 10,
  //           retryBuilder: (context, callback) {
  //             return RaisedButton(
  //                 child: Text('Retry'), onPressed: () => callback());
  //           },
  //           shrinkWrap: true,
  //           itemBuilder: this._restaurantsItem,
  //           noItemsFoundBuilder: (context) {
  //             return Text(
  //               'لا يوجد منتجات',
  //               style: AppStyle.textStyle15,
  //             );
  //           },
  //           pageFuture: (pageIndex) =>
  //
  //           loadingBuilder: (BuildContext context) =>
  //               horizontalShimmer(context: context));
  //     },
  //   );
  // }
}
