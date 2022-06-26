import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/before_confirm_response_model.dart';
import 'package:afsha/screen/%20pick_location/location_provider.dart';
import 'package:afsha/screen/%20pick_location/pick_location.dart';
import 'package:afsha/screen/captains_list/offer_provider.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/screen/order_confirmation%20_done/order_confirmation%20_done.dart';
import 'package:afsha/screen/restaurant_details/restaurant_details_provider.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_confirmation_provider.dart';

class OrderConfirmation extends StatefulWidget {
  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //   context.read<OrderConfirmationProvider>().getCartData(context: context);
      context
          .read<OrderConfirmationProvider>()
          .getBeforeConfirm(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderConfirmationProvider = context.watch<OrderConfirmationProvider>();
    var mapProvider = context.watch<LocationProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: Text(
          'تأكيد الطلب',
          style: AppStyle.textStyle15.copyWith(color: AppColors.mainColor),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close,
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
      body: orderConfirmationProvider.beforeConfirmLoader
          ? Column(
            children: [
              horizontalShimmer(context: context, height: 68.h, itemCount: 2),
              horizontalShimmer(context: context, height: 20.h, itemCount: 1,width: 70.w),
              horizontalShimmer(context: context, height: 40.h, itemCount: 1,width: 100.w),
              horizontalShimmer(context: context, height: 20.h, itemCount: 1,width: 70.w),
            ],
          )
          : orderConfirmationProvider?.beforeConfirmResponseModel?.data != null
              ? Column(
                  children: [
                    Expanded(
                        child: ListView(
                      children: [
                        ...orderConfirmationProvider?.productList?.map(
                          (e) => Column(
                            children: [
                              Text(
                                e.storeList,
                                style: AppStyle.textStyle12
                                    .copyWith(color: AppColors.blackColor),
                              ),
                              ...e.productsList.map(
                                (OrderProductData order) =>
                                    restaurantsItem(order),
                              ),
                              Divider(
                                color: AppColors.mainColor.withOpacity(0.5),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 10,
                          trailing: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.binkColor,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 3),
                                child: Text(
                                  orderConfirmationProvider
                                          ?.beforeConfirmResponseModel
                                          ?.data
                                          ?.paymentMethod ??
                                      '',
                                  style: AppStyle.textStyle10.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              )),
                          title: Text(
                            'الدفع نقداَ عند الإستلام',
                            style: AppStyle.textStyle10.copyWith(
                                fontSize: 12, color: AppColors.blackColor),
                          ),
                          leading: Icon(
                            Icons.check_circle,
                            color: AppColors.locationColor,
                          ),
                        ),
                        Divider(
                          color: AppColors.mainColor.withOpacity(0.5),
                        ),
                        Text(
                          'موقع تسليم الطلب',
                          style: AppStyle.textStyle12.copyWith(fontSize: 13),
                        ),
                        InkWell(
                          onTap: () => NavigatorX.push(context, PickLocation()),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            minLeadingWidth: 10,
                            trailing: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.binkColor,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    'اختر موقع آخر',
                                    style: AppStyle.textStyle10
                                        .copyWith(fontSize: 12),
                                  ),
                                )),
                            title: Container(
                              width: MediaQuery.of(context).size.width * .7,
                              child: Text(mapProvider.address ?? 'حدد موقعك',
                                  style: AppStyle.textStyle12.copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            leading: Icon(
                              Icons.location_on,
                              color: AppColors.locationColor,
                            ),
                          ),
                        ),
                        Divider(
                          color: AppColors.mainColor.withOpacity(0.5),
                        ),
                        Text(
                          'وقت التوصيل',
                          style: AppStyle.textStyle12.copyWith(fontSize: 13),
                        ),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          minLeadingWidth: 10,
                          title: Text(
                            ' في خلال  ${orderConfirmationProvider?.beforeConfirmResponseModel?.data?.deliveryTime ?? ''} ',
                            style: AppStyle.textStyle10.copyWith(
                                fontSize: 12, color: AppColors.blackColor),
                          ),
                          leading: FaIcon(
                            FontAwesomeIcons.solidClock,
                            color: AppColors.mainColor,
                            size: 18,
                          ),
                        ),
                      ],
                    ).addPaddingHorizontalVertical(horizontal: 16)),
                    Column(
                      children: [
                        Container(
                          width: context.width,
                          decoration: BoxDecoration(
                            color: AppColors.binkColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'المجموع',
                                  style: AppStyle.textStyle15,
                                ),
                                Text(
                                  orderConfirmationProvider
                                          .beforeConfirmResponseModel
                                          ?.data
                                          ?.total
                                          .toString() ??
                                      '' + ' ' + ' ريال.س ',
                                  style: AppStyle.textStyle15
                                      .copyWith(color: AppColors.mainColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        EduButton(
                          onPressed: () {
                            context
                                .read<OrderConfirmationProvider>()
                                .doneOrder(context: context);
                            //_modalBottomSheetMenu();
                          },
                          width: context.width,
                          bgColor:
                              MaterialStateProperty.all(AppColors.mainColor),
                          title: 'تأكيد الطلب',
                          style: AppStyle.textStyle15
                              .copyWith(color: AppColors.whiteColor),
                        ),
                      ],
                    )
                  ],
                )
              : Center(
                  child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'لا يوجد طلبات الان بالرجاء الرجوع الي ',
                    style: AppStyle.textStyle15,
                    children: <TextSpan>[
                      TextSpan(
                        text: '\nالصفحه الرئيسيه',
                        style: TextStyle(
                            color: AppColors.mainColor,
                            decoration: TextDecoration.underline),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage(
                                          index: 0,
                                        )));
                          },
                      ),
                    ],
                  ),
                )).addPaddingHorizontalVertical(horizontal: 10),
    );
  }

  Widget restaurantsItem(OrderProductData item) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor, boxShadow: AppColors.boxShadow),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(gradient: AppColors.gradient),
                child: cachedNetworkImageX(
                    imageUrl: item.productImage, boxFit: BoxFit.cover),
                height: 73.h,
              ),
            ),
            SizedBox(width: 5),
            Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productTitle,
                      style: AppStyle.textStyle12
                          .copyWith(color: AppColors.blackColor),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          item.productPrice.toString(),
                          style: AppStyle.textStyle12
                              .copyWith(color: AppColors.mainColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'ريال سعودي',
                          style: AppStyle.textStyle12
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ],
                ).addPaddingOnly(top: 10)),
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
                          context
                              .read<OrderConfirmationProvider>()
                              .updateQuantity(
                                  context: context,
                                  cardId: item.id.toString(),
                                  quantity: item.productQuantity.toInt() + 1);
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
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(
                      item.productQuantity.toString(),
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
                          context
                              .read<OrderConfirmationProvider>()
                              .updateQuantity(
                                  context: context,
                                  cardId: item.id.toString(),
                                  quantity: item.productQuantity.toInt() - 1);
                          if (item.productQuantity == 1) {
                            context
                                .read<OrderConfirmationProvider>()
                                .cartDelete(context: context, cardId: item.id);
                            print('Deleteeeeeeeeeeee');
                          }
                        },
                        icon: Icon(
                          item.productQuantity == 1
                              ? Icons.delete
                              : Icons.remove,
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
    );
  }
}
