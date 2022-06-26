import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/offer_response_model.dart';
import 'package:afsha/model/pusher_response.dart';
import 'package:afsha/screen/order_status_details/order_cancel.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/animationWidget.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import 'offer_provider.dart';

class CaptainsList extends StatefulWidget {
  @override
  _CaptainsListState createState() => _CaptainsListState();

  CaptainsList();
}

class _CaptainsListState extends State<CaptainsList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // context.read<OfferProvider>().getOffer(context: context);
    });
  }

  ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);
  changeSelectedIndex(int newIndex) => selectedIndexNotifier.value = newIndex;

  void startTimer({List<PusherResponse> capList, int itemStart, int id}) {
    new Future.delayed(Duration(seconds: itemStart), () {
      capList.removeWhere((element) => element.id == id);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var offerProvider = context.watch<OfferProvider>();
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Column(
          children: [
            Expanded(
                child: ListView(
              shrinkWrap: true,
              children: offerProvider.captainList.map((e) {
                int index = offerProvider.captainList.indexOf(e);
                int displaySeconds = index + 15;
                startTimer(
                    capList: offerProvider.captainList,
                    itemStart: displaySeconds,
                    id: e.id);
                return _captainCard(e);
              }).toList(),
            )),
            EduButton(
              onPressed: () {
                showOrderCancel(
                    context: context,
                    orderId: offerProvider.offerList.firstOrNull.orderId);
              },
              width: context.width * 0.55,
              bgColor: MaterialStateProperty.all(AppColors.mainColor),
              title: 'إلغاء الطلب',
              style: AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
            ).addPaddingHorizontalVertical(vertical: 10),
          ],
        ));
  }

  Widget _captainCard(PusherResponse offerData) {
    return InkWell(
      //  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetails())),
      child: Container(
        height: 89.h,
        decoration: BoxDecoration(
            color: AppColors.whiteColor, boxShadow: AppColors.boxShadow),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(gradient: AppColors.gradient),
                child: cachedNetworkImageX(
                    imageUrl: offerData.image, boxFit: BoxFit.cover),
                height: 89.h,
              ),
            ),
            Expanded(
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            offerData.username,
                            style: AppStyle.textStyle12
                                .copyWith(color: AppColors.blackColor),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Resources.PRICE),
                              SizedBox(
                                width: 3,
                              ),
                              RichText(
                                text: TextSpan(
                                  text: offerData.price.toString(),
                                  style: AppStyle.textStyle15
                                      .copyWith(color: AppColors.mainColor),
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: 'ريال سعودي',
                                        style: TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 10)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.directions_car_rounded,
                                size: 15,
                                color: AppColors.locationColor,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                offerData.distance,
                                style: AppStyle.textStyle12
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ],
                          ),
                          Container(
                            height: 15,
                            width: 1,
                            color: AppColors.mainColor,
                          ).addPaddingHorizontalVertical(horizontal: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 15,
                                color: AppColors.yellowColor,
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                offerData.rate.toString(),
                                style: AppStyle.textStyle12
                                    .copyWith(color: AppColors.blackColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<OfferProvider>().approveOffer(
                                  context: context, offerId: offerData.id);
                            },
                            child: Container(
                              height: 19.h,
                              decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(5)),
                              width: context.width * 0.2,
                              child: Text(
                                'قبول',
                                style: AppStyle.textStyle10.copyWith(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 19.h,
                              decoration: BoxDecoration(
                                  color: AppColors.binkColor,
                                  borderRadius: BorderRadius.circular(5)),
                              width: context.width * 0.2,
                              child: Text(
                                'رفض',
                                style: AppStyle.textStyle10.copyWith(
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ).addPaddingHorizontalVertical(vertical: 8, horizontal: 10),
    );
  }
  // Widget listViewBuilder(OfferProvider offerProvider) {
  //   return PagewiseListView<OfferData>(
  //       pageSize: 10,
  //       shrinkWrap: true,
  //       itemBuilder: this._captainCard,
  //       noItemsFoundBuilder: (context) {
  //         return Text('No Items Found');
  //       },
  //       pageFuture: (pageIndex) => offerProvider.initPusher(),
  //       loadingBuilder: (BuildContext context) => horizontalShimmer(context: context));
  // }
}
