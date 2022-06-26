import 'package:afsha/model/offer_response_model.dart';
import 'package:afsha/screen/captains_list/offer_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import '../../Components/Style.dart';
import '../../Components/Widget/EduButton.dart';
import '../../Components/Widget/ProfilePageTextFileds.dart';
import '../../tools/AppColors.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

List<String> _reasonForCancellation = [
  'لا اريد هذه السلعة',
  'اعيد التفكير',
  'سوف اطلب في وقت لاحق',
  'غير مناسب لي',
  'اسباب اخري ...'
]; // Option 1
String _selectedLocation; // Option 1
TextEditingController comment = TextEditingController();
Future<void> showOrderCancel(
    {BuildContext context, int orderId}) async {
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: 420.h,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Container(
                  width: 45,
                  height: 3,
                  decoration: BoxDecoration(
                      color: Color(0xff9FA1B5),
                      borderRadius: BorderRadius.circular(50)),
                ).setCenter(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "إلغاء الطلب",
                      style: AppStyle.textStyle15,
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close))
                  ],
                ).addPaddingHorizontalVertical(vertical: 10),
                Divider(),
                Text(
                  "سبب الإلغاء",
                  style: AppStyle.textStyle12,
                ).addPaddingHorizontalVertical(horizontal: 16),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    height: 43,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.mainColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      hint: Text('اختر سبب الإلغاء'),
                      style: AppStyle.textStyle12
                          .copyWith(color: AppColors.grayDarkColor),
                      isExpanded: true,
                      iconEnabledColor: AppColors.grayDarkColor,
                      value: _selectedLocation,
                      onChanged: (newValue) {
                        _selectedLocation = newValue;
                      },
                      items: _reasonForCancellation.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ))).addPaddingHorizontalVertical(
                  vertical: 10,
                ),
                Text(
                  "تعليقك علي المنتج",
                  style: AppStyle.textStyle12
                      .copyWith(color: AppColors.blackColor),
                ),
                Container(
                    padding: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.mainColor.withOpacity(0.2)),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: TextFormField(
                      maxLines: 4,
                      controller: comment,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: 'تعليقك علي المنتج',
                        hintStyle: AppStyle.textStyle12
                            .copyWith(color: AppColors.grayDarkColor),
                      ),
                    )).addPaddingHorizontalVertical(vertical: 10),
                EduButton(
                  onPressed: () {
                    print('cancel order');
                    context.read<OfferProvider>().cancelOffer(
                        context: context,
                        orderId: orderId,
                      reasonForCancellation: _selectedLocation,
                      comment: comment.text
                    );
                  },
                  width: context.width,
                  bgColor: MaterialStateProperty.all(AppColors.mainColor),
                  title: 'إرسال طلب الإسترجاع',
                  style: AppStyle.textStyle15
                      .copyWith(color: AppColors.whiteColor),
                ).addPaddingHorizontalVertical(vertical: 10)
              ],
            ).addPaddingHorizontalVertical(horizontal: 16),
          ),
        );
      });
}
