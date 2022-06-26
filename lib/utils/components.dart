import 'dart:ui';

import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/AppReources.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:afsha/extensions/extension.dart';
Widget customRichText({
   BuildContext context,
   String firstText,
   String secondText,
   TextStyle firstTextStyle,
   TextStyle secondTextStyle,
  VoidCallback onFirstTextTapped,
  VoidCallback onSecondTextTapped,
}) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: firstText,
        style: firstTextStyle,
        recognizer: TapGestureRecognizer()..onTap = onFirstTextTapped,
        children: <TextSpan>[
          TextSpan(
            text: secondText,
            style: secondTextStyle,
            recognizer: TapGestureRecognizer()..onTap = onSecondTextTapped,
          ),
        ]),
  );
}
void showToast({ String message, Color backgroundColor = Colors.black}) {
  HapticFeedback.lightImpact();
  Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: Colors.white,
      fontSize: 16.0);
}
void showFlushBar(
    {@required BuildContext context, String title, @required String message}) {
  Flushbar(
    backgroundColor: AppColors.binkColor,
    padding: EdgeInsets.only(right: 16, left: 16, top: 16, bottom: 16),
    title: title ?? Constants.ERROR_TITLE,
    titleColor:AppColors.blackColor,
    messageColor: AppColors.blackColor,
    borderColor: AppColors.mainColor.withOpacity(.5),
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    duration: Duration(seconds: 3),
  ).show(context);
}
Widget cachedNetworkImageX({ imageUrl, BoxFit boxFit}) {
  return CachedNetworkImage(
    imageUrl: imageUrl ?? Constants.IMAGE_PLACE_HOLDER,
    fit: boxFit ?? BoxFit.cover,
    placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
        )),
    errorWidget: (context, url, error) => CachedNetworkImage(
        imageUrl:  Constants.IMAGE_PLACE_HOLDER,
      fit: BoxFit.cover,
    ),
  );
}
Widget cachedNetworkImageXCir({ imageUrl, BoxFit boxFit}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10000.0),
    child: CachedNetworkImage(
      imageUrl: imageUrl ?? Constants.IMAGE_PLACE_HOLDER,
      fit: boxFit ?? BoxFit.cover,
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
             // shape: BoxShape.circle
            ),
          )),
      errorWidget: (context, url, error) => CachedNetworkImage(
          imageUrl:  Constants.IMAGE_PLACE_HOLDER,
        fit: BoxFit.cover,
      ),
    ),
  );
}
Widget cachedNetworkImageXRectangle({@required imageUrl, BoxFit boxFit, BuildContext context}) {
  return CachedNetworkImage(
    imageUrl: imageUrl ?? Constants.IMAGE_PLACE_HOLDER,
    fit: boxFit ?? BoxFit.cover,
    placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
        child: Container(
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
        )),
    errorWidget: (context, url, error) => CachedNetworkImage(
      imageUrl:  Constants.IMAGE_PLACE_HOLDER,
      fit: BoxFit.cover,
    ),
  );
}
Widget horizontalShimmer({double height,double width, BuildContext context,int itemCount}) {
  return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: itemCount ??1,
      itemBuilder: (context, index) => Container(
        width:   width??context.width,
        height: height?? 80,
        child: Image.asset(Resources.IMAGE_4,fit: BoxFit.cover,),
      ).addPaddingHorizontalVertical(vertical: 5).shimmerWhenLoading(true, duration: Duration(milliseconds: 1000)));
}
Widget gridShimmer({ BuildContext context, int itemCount}) {
  return GridView.count(
    shrinkWrap: true,
    crossAxisSpacing: 18,
    mainAxisSpacing: 0,
    childAspectRatio: context.width / (context.height * .37.h),
    crossAxisCount: 2,
    children: List.generate(itemCount ?? 4, (index) {
      return Container(
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            Resources.IMAGE_4,
            fit: BoxFit.cover,
          )).shimmerWhenLoading(true);
    }),
  );
}
class ProductShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 300.h,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ).shimmerWhenLoading(true,
                        duration: Duration(milliseconds: 600)),

                    Positioned(
                        right: 10,
                        top: 30,
                        child: Column(
                          children: [
                            InkWell(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(50),
                                    color: AppColors.whiteColor),
                                child: Icon(
                                    Icons.favorite_outline_rounded),
                              ),
                            ).shimmerWhenLoading(true),
                            SizedBox(height: 10),
                            InkWell(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(50),
                                    color: AppColors.whiteColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      Resources.COMPARE_ICON,
                                      color: AppColors.blackColor),
                                ),
                              ),
                            ).shimmerWhenLoading(true),
                          ],
                        )),

                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                )
                    .addPaddingHorizontalVertical(horizontal: 16)
                    .shimmerWhenLoading(true),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ).shimmerWhenLoading(true),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.20,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ).shimmerWhenLoading(true),
                  ],
                ).addPaddingHorizontalVertical(horizontal: 16),
              ],
            )),
      ],
    );
  }
}