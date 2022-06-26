import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/model/order/order_details_response_model.dart';
import 'package:afsha/screen/captains_list/offer_provider.dart';
import 'package:afsha/screen/order_status/order_status_provider.dart';
import 'package:afsha/screen/order_status/order_stepper.dart';
import 'package:afsha/screen/order_status_details/order_status_details.dart';
import 'package:afsha/screen/order_status_details/stepper.dart';
import 'package:afsha/screen/regstration_Screen/registration_provider.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../ServiceStatusStepper.dart';
import 'order_cancel.dart';

ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

class OrderStatusDetails extends StatefulWidget {
  final OrderDetailsList orderDetailsList;
  OrderStatusDetails({this.orderDetailsList});

  @override
  _OrderStatusDetailsState createState() => _OrderStatusDetailsState();
}

class _OrderStatusDetailsState extends State<OrderStatusDetails> {
  ValueNotifier<int> selectedIndex = ValueNotifier(1);
  selectedIndexChange(int index) {
    selectedIndex.value = index;
  }

  changeSelectedIndex(int newIndex) => selectedIndexNotifier.value = newIndex;
  final PageController controller = PageController(initialPage: 1);
  List<Widget> pageList() => [
        rowOne(
            name: 'في انتظار تأكيد المندوب لطلبك ',
            mess: 'يمكنك إلغاء طلبك في تلك الحالة فقط '),
        rowOne(
            name: 'تم تغليف وتعبئة الطلب للشحن استعد لاستقباله ',
            mess: 'تم قبول طلبك من قبل المندوب ولا يمكنك إلغائه'),
        rowOne(
            name: 'استعد لإستقبال طلبك ',
            mess: 'تم قبول طلبك من قبل المندوب ولا يمكنك إلغائه'),
        rowOne(
            name: 'في انتظار تأكيد المندوب لطلبك ',
            mess: 'تم قبول طلبك من قبل المندوب ولا يمكنك إلغائه'),
        rowOne(
            name: 'في انتظار تأكيد المندوب لطلبك ',
            mess: 'تم قبول طلبك من قبل المندوب ولا يمكنك إلغائه'),
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var provider = context.read<OrderStatusProvider>();
      if (provider.orderStatusIndex(
              orderStatus: provider.orderList.data.status) == 3) {
        context.read<OrderStatusProvider>().getReceivedOrder(context: context,);
        _modalBottomSheetMenu();
      }
    });
  }

  ValueNotifier<String> receivedNotifier = ValueNotifier<String>(null);
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<OrderStatusProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.whiteColor,
          title: Text(
            'حالة الطلب',
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
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              ServiceStatusStepper(
                processIndex: provider.orderStatusIndex(
                    orderStatus: provider.orderList.data.status),
                onChanged: (int) => selectedIndexChange(int),
              ),
              // OrderStepper(
              //   onChanged: (int) => selectedIndexChange(int),
              // ),
              pageList()[provider.orderStatusIndex(
                  orderStatus: provider.orderList.data.status)]
            ],
          )),
          ValueListenableBuilder(
            valueListenable: selectedIndex,
            builder: (BuildContext context, int selectedIndex, _) {
              return provider.orderStatusIndex(
                          orderStatus: provider.orderList.data.status) ==
                      0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => showOrderCancel(
                              context: context,
                              orderId: provider.orderList.data.id),
                          child: Container(
                            width: context.width * 0.5,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: AppColors.mainColor),
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(
                                child: Text('إلغاء الطلب',
                                    style: AppStyle.textStyle15
                                        .copyWith(color: AppColors.mainColor))),
                          ),
                        )
                      ],
                    ).addPaddingHorizontalVertical(vertical: 20)
                  : SizedBox(
                      height: 40,
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget rowOne({String name, String mess}) {
    var orderStatusProvider = context.watch<OrderStatusProvider>();
    return Column(
      children: [
        ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: AppStyle.textStyle10
                      .copyWith(color: AppColors.grayDarkColor),
                ),
              ],
            ).addPaddingHorizontalVertical(horizontal: 16, vertical: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'عناصر الطلب',
                      style: AppStyle.textStyle10
                          .copyWith(color: AppColors.blackColor),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          color: AppColors.binkColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 7,
                            right: 7,
                          ),
                          child: Text('3', style: AppStyle.textStyle10),
                        )),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'رقم الطلب',
                      style: AppStyle.textStyle10
                          .copyWith(color: AppColors.blackColor),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                        orderStatusProvider.orderList.data.orderNumber
                            .toString(),
                        style: AppStyle.textStyle10),
                  ],
                ),
              ],
            ).addPaddingHorizontalVertical(horizontal: 16, vertical: 10),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: orderStatusProvider.orderList.data.products.length,
                itemBuilder: (context, index) {
                  Product item =
                      orderStatusProvider.orderList.data.products[index];
                  return _restaurantsItem(context, item);
                })
          ],
        ),
        Row(
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
              mess,
              style: AppStyle.textStyle12.copyWith(color: AppColors.blackColor),
            ),
          ],
        ).addPaddingHorizontalVertical(horizontal: 16, vertical: 10),
      ],
    );
  }

  Widget _restaurantsItem(BuildContext context, Product product) {
    return InkWell(
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

  void _modalBottomSheetMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Consumer<OrderStatusProvider>(
              builder: (BuildContext context, provider, _) => provider
                          .orderResponseLoader ==
                      true
                  ? CupertinoActivityIndicator()
                  : Container(
                      height: 330.h,
                      decoration: BoxDecoration(
                        color: Colors
                            .transparent, //could change this to Color(0xFF737373),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: provider?.orderResponseModel?.data == null
                            ? Text('لا توجد بيانات').setCenter()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Container(
                                    width: 45,
                                    height: 3,
                                    decoration: BoxDecoration(
                                        color: Color(0xff9FA1B5),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                  ).setCenter(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "تأكيد استلام الطلب",
                                        style: AppStyle.textStyle15,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'رقم الطلب ',
                                          style: AppStyle.textStyle10.copyWith(
                                              color: AppColors.blackColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: provider
                                                    .orderResponseModel
                                                    .data
                                                    .orderNumber
                                                    .toString(),
                                                style: TextStyle(
                                                    color:
                                                        AppColors.mainColor)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ).addPaddingHorizontalVertical(vertical: 10),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "اسم المندوب ",
                                              style: AppStyle.textStyle12
                                                  .copyWith(
                                                      fontFamily: 'SemiBold'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "اسم البراند",
                                              style: AppStyle.textStyle12
                                                  .copyWith(
                                                      fontFamily: 'SemiBold'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "مكونات الطلب",
                                              style: AppStyle.textStyle12
                                                  .copyWith(
                                                      fontFamily: 'SemiBold'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "المجموع الكلي ",
                                              style: AppStyle.textStyle12
                                                  .copyWith(
                                                      fontFamily: 'SemiBold'),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              provider.orderResponseModel.data
                                                  .deliveryName,
                                              style: AppStyle.textStyle12
                                                  .copyWith(
                                                      fontFamily: 'Cairo',
                                                      color:
                                                          AppColors.mainColor),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            ...provider.orderResponseModel.data
                                                .storeAndProducts
                                                .map((e) {
                                              return Text(
                                                e.title,
                                                style: AppStyle.textStyle12,
                                              );
                                            }),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            ...provider.orderResponseModel.data
                                                .storeAndProducts
                                                .map((e) {
                                              return Text(
                                                e?.description ?? 'لا يوجد وصف',
                                                style: AppStyle.textStyle12,
                                              );
                                            }),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${provider.orderResponseModel.data.total} ريال سعودي ",
                                              style: AppStyle.textStyle12,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              gradient: AppColors.gradient),
                                          child: cachedNetworkImageX(
                                              imageUrl: provider
                                                  .orderResponseModel
                                                  .data
                                                  .storeAndProducts
                                                  .first
                                                  .productImage,
                                              boxFit: BoxFit.cover),
                                          height: 60.h,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Transform.translate(
                                    offset: const Offset(15.0, 00),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          ChangeNotifierProvider<
                                              RegistrationProvider>(
                                            create: (context) =>
                                                RegistrationProvider(),
                                            child:
                                                Consumer<RegistrationProvider>(
                                              builder: (context, loginprovider,
                                                      child) =>
                                                  Checkbox(
                                                value: loginprovider.remember,
                                                fillColor:
                                                    MaterialStateProperty.all(
                                                        AppColors.mainColor),
                                                onChanged: (value) {
                                                  loginprovider
                                                      .changeRemember(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          const Text(
                                              "وافق علي انه تم استلام الطلب الخاص بي "),
                                        ],
                                      ),
                                    ),
                                  ),
                                  EduButton(
                                    onPressed: () {
                                      print('cancel order');
                                      context
                                          .read<OrderStatusProvider>()
                                          .receivedOrder(
                                              context: context,
                                              orderId: provider
                                                  .orderResponseModel.data.id,
                                              onSuccess: () {
                                                selectedIndexNotifier.value = 4;
                                              });
                                    },
                                    width: context.width,
                                    bgColor: MaterialStateProperty.all(
                                        AppColors.mainColor),
                                    title: 'تأكيد إستلام الطلب',
                                    style: AppStyle.textStyle15
                                        .copyWith(color: AppColors.whiteColor),
                                  ).addPaddingHorizontalVertical(vertical: 20)
                                ],
                              ).addPaddingHorizontalVertical(horizontal: 16),
                      )),
            );
          });
    });
  }
}
