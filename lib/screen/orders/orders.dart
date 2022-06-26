import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/order/my_order_response_model.dart';
import 'package:afsha/screen/order_status/order_status.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'order_provider.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<OrderProvider>().getOrder(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderProvider = context.watch<OrderProvider>();
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'طلباتي',
            style: AppStyle.textStyle15,
          ),
          automaticallyImplyLeading: false,
        ),
        body: (orderProvider?.orderList?.length ?? 0) > 0?
        SingleChildScrollView(
          child: orderProvider.orderLoader
              ? horizontalShimmer(context: context,itemCount: 4)
              :  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: orderProvider?.orderList
                              ?.map((OrderDataList orderData) => InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                  builder: (context) =>
                                  OrderStatus(
                                    orderId: orderData.id,
                                    status:  orderProvider.orderTitle(
                                        orderStatus: orderData.status),
                                  )));
                            },
                                child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'رقم الطلب',
                                                    style: AppStyle.textStyle12
                                                        .copyWith(
                                                            color: AppColors
                                                                .blackColor),
                                                  ).addPaddingOnly(left: 6),
                                                  Text(
                                                    orderData.orderNumber
                                                        .toString(),
                                                    style: AppStyle.textStyle12
                                                        .copyWith(
                                                            color: AppColors
                                                                .mainColor),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'عرض التفاصيل',
                                                    style: AppStyle
                                                        .textStyle12
                                                        .copyWith(
                                                            color: AppColors
                                                                .mainColor),
                                                  ).addPaddingOnly(left: 6),
                                                  Icon(
                                                    Icons.arrow_forward_ios,
                                                    color:
                                                        AppColors.mainColor,
                                                    size: 18,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ).addPaddingOnly(bottom: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'طلبته يوم ',
                                                    style: AppStyle.textStyle10,
                                                  ).addPaddingOnly(left: 6),
                                                  Text(
                                                    orderData.date,
                                                    style: AppStyle.textStyle10
                                                        .copyWith(
                                                            color: AppColors
                                                                .grayDarkColor),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    gradient: AppColors.gradient),
                                                child: Text(
                                                  orderProvider.orderTitle(
                                                      orderStatus: orderData.status),
                                                  style: AppStyle.textStyle10.copyWith(color: AppColors.mainColor),
                                                ).addPaddingHorizontalVertical(
                                                    horizontal: 10, vertical: 5),
                                              ),
                                            ],
                                          ),
                                          ...orderData.products.map(
                                              (Product product) =>
                                                  restaurantsItem(product))
                                        ],
                                      ),
                                    ).addPaddingOnly(bottom: 10),
                              ))
                              ?.toList()).addPaddingHorizontalVertical(horizontal: 16)

        ): Center(child: SvgPicture.asset(Resources.ordersV)),);
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
                    imageUrl: product.image, boxFit: BoxFit.cover),
                height: 60.h,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
                flex: 4,
                child: Column(
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
