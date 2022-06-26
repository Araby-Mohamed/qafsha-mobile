import 'dart:io';
import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/order/order_details_response_model.dart';
import 'package:afsha/screen/order_status/order_rate.dart';
import 'package:afsha/screen/order_status_details/order_status_details.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/src/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'order_status_provider.dart';
import 'order_stepper.dart';

class OrderStatus extends StatefulWidget {
  final int orderId;
  final String status;
  OrderStatus({this.orderId, this.status});

  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  selectedIndexChange(int index) {
    selectedIndex.value = index;
  }

  final PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
          .read<OrderStatusProvider>()
          .getOrderDetails(context: context, orderId: widget.orderId);
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = context.watch<OrderStatusProvider>();
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.whiteColor,
            title: Text(
              'تفاصيل الطلب',
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
        body: orderProvider.orderLoader
            ? horizontalShimmer(context: context)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        border: TableBorder(
                          horizontalInside: BorderSide(
                              width: 1.5, color: AppColors.grayColor),
                          top: BorderSide(
                              width: 1.5, color: AppColors.grayColor),
                          bottom: BorderSide(
                              width: 1.5, color: AppColors.grayColor),
                          left: BorderSide(
                              width: 1.5, color: AppColors.grayColor),
                          right: BorderSide(
                              width: 1.5, color: AppColors.grayColor),
                        ),
                        children: [
                          TableRow(
                              decoration:
                                  new BoxDecoration(color: AppColors.binkColor),
                              children: [
                                Text(
                                  "رقم الطلب",
                                  style: AppStyle.textStyle12
                                      .copyWith(color: AppColors.mainColor),
                                ).addPaddingAll(5),
                                Text(
                                        orderProvider
                                            ?.orderList?.data?.orderNumber
                                            .toString(),
                                        style: AppStyle.textStyle12)
                                    .addPaddingAll(5)
                              ]),
                          TableRow(children: [
                            Text('تاريخ الطلب',
                                    style: AppStyle.textStyle12.copyWith(
                                        color: AppColors.grayDarkColor))
                                .addPaddingAll(5),
                            Text(orderProvider?.orderList?.data?.date,
                                    style: AppStyle.textStyle12)
                                .addPaddingAll(5),
                          ]),
                          TableRow(children: [
                            Text('المجموع الكلي (يشمل الضريبة والتوصيل)',
                                    style: AppStyle.textStyle12.copyWith(
                                        color: AppColors.grayDarkColor))
                                .addPaddingAll(5),
                            Text('${orderProvider.orderList.data.shippingDetails.totalIncludesShippingCosts} ريال سعودي ',
                                    style: AppStyle.textStyle12)
                                .addPaddingAll(5),
                          ]),
                          TableRow(children: [
                            Text('طريقة الدفع',
                                    style: AppStyle.textStyle12.copyWith(
                                        color: AppColors.grayDarkColor))
                                .addPaddingAll(5),
                            Text(
                                    orderProvider.orderCash(
                                        orderStatus: orderProvider
                                            .orderList.data.paymentMethod),
                                    style: AppStyle.textStyle12)
                                .addPaddingAll(5),
                          ]),
                        ],
                      ).addPaddingHorizontalVertical(horizontal: 16),
                      Theme(
                        data: ThemeData()
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          textColor: AppColors.mainColor,
                          iconColor: AppColors.blackColor,
                          initiallyExpanded: true,
                          title: Text(
                            'تفاصيل الشحن',
                            style: AppStyle.textStyle12.copyWith(fontSize: 14),
                          ),
                          children: [
                            Table(
                              defaultVerticalAlignment:
                                  TableCellVerticalAlignment.middle,
                              border: TableBorder(
                                horizontalInside: BorderSide(
                                    width: 1.5, color: AppColors.grayColor),
                                top: BorderSide(
                                    width: 1.5, color: AppColors.grayColor),
                                bottom: BorderSide(
                                    width: 1.5, color: AppColors.grayColor),
                                left: BorderSide(
                                    width: 1.5, color: AppColors.grayColor),
                                right: BorderSide(
                                    width: 1.5, color: AppColors.grayColor),
                              ),
                              children: [
                                TableRow(children: [
                                  Text("الاسم",
                                          style: AppStyle.textStyle12.copyWith(
                                              color: AppColors.grayDarkColor))
                                      .addPaddingAll(5),
                                  Text(
                                          orderProvider.orderList.data
                                              .shippingDetails.username,
                                          style: AppStyle.textStyle12)
                                      .addPaddingAll(5)
                                ]),
                                TableRow(children: [
                                  Text('رقم الموبايل',
                                          style: AppStyle.textStyle12.copyWith(
                                              color: AppColors.grayDarkColor))
                                      .addPaddingAll(5),
                                  Text(
                                          orderProvider.orderList.data
                                              .shippingDetails.phone,
                                          style: AppStyle.textStyle12)
                                      .addPaddingAll(5),
                                ]),
                                TableRow(children: [
                                  Text('العنوان،',
                                          style: AppStyle.textStyle12.copyWith(
                                              color: AppColors.grayDarkColor))
                                      .addPaddingAll(5),
                                  Text(
                                          orderProvider?.orderList?.data
                                                  ?.shippingDetails?.address ??
                                              'لا يوجد عنوان',
                                          style: AppStyle.textStyle12)
                                      .addPaddingAll(5),
                                ]),
                              ],
                            ).addPaddingHorizontalVertical(horizontal: 16),
                          ],
                        ),
                      ),
                 /*     Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              showOrderRate(context);
                            },
                            child: Container(
                              width: context.width * 0.5,
                              height: 40,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.mainColor),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                  child: Text('تقييم الطلب',
                                      style: AppStyle.textStyle15.copyWith(
                                          color: AppColors.mainColor))),
                            ),
                          )
                        ],
                      ).addPaddingHorizontalVertical(vertical: 20),*/

                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Text(
                            'حالة الطلب',
                            style: AppStyle.textStyle12,
                          ),
                        ],
                      ).addPaddingHorizontalVertical(
                          horizontal: 16, vertical: 7),
                      Container(
                        decoration: BoxDecoration(color: AppColors.binkColor),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.status,
                              style: AppStyle.textStyle12,
                            ),
                            if (widget.status != 'تم الالغاء')
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OrderStatusDetails(
                                                orderDetailsList: orderProvider
                                                    .orderList.data,
                                              )));
                                },
                                child: Row(
                                  children: [
                                    Text('تابع حالة الطلب',
                                        style: AppStyle.textStyle12.copyWith(
                                            color: AppColors.mainColor)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: AppColors.mainColor,
                                      size: 15,
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ).addPaddingHorizontalVertical(
                            vertical: 10, horizontal: 6),
                      ).addPaddingHorizontalVertical(horizontal: 16),
                      //  OrderStatusStepper(),
                      //rowOne(orderProvider),
                    ],
                  )),
                  Container(
                    color: AppColors.binkColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.warning,
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'يمكنك إرجاع الطلب في حالة عدم استلام المندوب الطلب',
                          style: AppStyle.textStyle12.copyWith(
                            fontFamily: "Cairo",
                          ),
                        ),
                      ],
                    ).addPaddingHorizontalVertical(
                        horizontal: 16, vertical: 12),
                  ),
                ],
              ));
  }

  Widget rowOne(OrderStatusProvider orderStatusProvider) {
    return ListView(
      shrinkWrap: true,
      children: [
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          border: TableBorder(
            horizontalInside:
                BorderSide(width: 1.5, color: AppColors.grayColor),
            top: BorderSide(width: 1.5, color: AppColors.grayColor),
            bottom: BorderSide(width: 1.5, color: AppColors.grayColor),
            left: BorderSide(width: 1.5, color: AppColors.grayColor),
            right: BorderSide(width: 1.5, color: AppColors.grayColor),
          ),
          children: [
            TableRow(children: [
              Text('رسوم الشحن',
                      style: AppStyle.textStyle12
                          .copyWith(color: AppColors.grayDarkColor))
                  .addPaddingAll(5),
              Text('${orderStatusProvider.orderList.data.shippingDetails.shippingExpenses} ريال سعودي ',
                      style: AppStyle.textStyle12)
                  .addPaddingAll(5),
            ]),
            TableRow(children: [
              Text('المطعم',
                      style: AppStyle.textStyle12
                          .copyWith(color: AppColors.grayDarkColor))
                  .addPaddingAll(5),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: orderStatusProvider.orderList.data.products.map((e) {
                  bool isLastIndex = orderStatusProvider.orderList.data.products
                          .indexOf(e) ==
                      orderStatusProvider.orderList.data.products.length - 1;
                  return Text('${e.title}  ${!isLastIndex ? '+' : ''}',
                          style: AppStyle.textStyle12)
                      .addPaddingAll(5);
                }).toList(),
              ),
            ]),
          ],
        ).addPaddingHorizontalVertical(horizontal: 16),
        ...orderStatusProvider.orderList.data.products
            .map((Product product) => restaurantsItem(product))
      ],
    );
  }

  Widget restaurantsItem(Product product) {
    return InkWell(
      //  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RestaurantDetails())),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.whiteColor, boxShadow: AppColors.boxShadow),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(gradient: AppColors.gradient),
                child: cachedNetworkImageX(
                    imageUrl: product.productImage, boxFit: BoxFit.cover),
                height: 60.h,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 4,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: AppStyle.textStyle15,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        Text(
                          'العدد',
                          style: AppStyle.textStyle12
                              .copyWith(color: AppColors.mainColor),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          product.quantity.toString(),
                          style: AppStyle.textStyle12
                              .copyWith(color: AppColors.blackColor),
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ).addPaddingHorizontalVertical(vertical: 7),
    );
  }
}
