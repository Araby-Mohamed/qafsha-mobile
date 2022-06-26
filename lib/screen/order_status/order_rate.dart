import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../Components/Style.dart';
import '../../Components/Widget/EduButton.dart';
import '../../Components/Widget/ProfilePageTextFileds.dart';
import '../../tools/AppColors.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ValueNotifier<double> _ratingNotifier = ValueNotifier<double>(0.0);

Future<void> showOrderRate(BuildContext context) async {
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          child: Container(
            height: 400.h,
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 45,
                  height: 3,
                  decoration: BoxDecoration(
                      color: Color(0xff9FA1B5),
                      borderRadius: BorderRadius.circular(50)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "تقييم المنتج",
                      style: AppStyle.textStyle15,
                    ),
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close))
                  ],
                ).addPaddingHorizontalVertical( vertical: 10),
                Divider(),
                ValueListenableBuilder(
                  valueListenable: _ratingNotifier,
                  builder: (BuildContext context, double rating, _) {
                    return Row(
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: SmoothStarRating(
                            rating: rating,
                            isReadOnly: false,
                            size: 35,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            color: AppColors.yellowColor,
                            borderColor: AppColors.grayLiteColor,
                            allowHalfRating: true,
                            spacing: 2.0,
                            onRated: (newRating) {
                              _ratingNotifier.value = newRating;
                            },
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text('${rating}', style: AppStyle.textStyle15),
                      ],
                    );
                  },
                ).addPaddingOnly(top: 10, bottom: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'اكتب تقييمك لتلك التجربة',
                      style: AppStyle.textStyle12.copyWith(
                        fontFamily: "Cairo",
                      ),
                    )
                  ],
                ),
                Container(
                        padding: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColors.mainColor.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: 'تعليقك علي المنتج',
                            hintStyle: AppStyle.textStyle12
                                .copyWith(color: AppColors.grayDarkColor),
                          ),
                        ))
                    .addPaddingHorizontalVertical(vertical: 10),
                EduButton(
                  onPressed: () {
                    print('done order');
                    //      Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderConfirmation()));
                  },
                  width: context.width,
                  bgColor: MaterialStateProperty.all(AppColors.mainColor),
                  title: 'إرسال التقييم',
                  style: AppStyle.textStyle15
                      .copyWith(color: AppColors.whiteColor),
                ).addPaddingHorizontalVertical( vertical: 15),
              ],
            ).addPaddingHorizontalVertical(horizontal: 16),
          ),
        );
      });
}
