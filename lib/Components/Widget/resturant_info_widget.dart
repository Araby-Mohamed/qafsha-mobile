import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../screen/restaurant_details/restaurant_details_provider.dart';
import '../../tools/AppColors.dart';
import '../Style.dart';
import 'package:afsha/extensions/extension.dart';

class RestaurantInfoContainer extends StatelessWidget {
  RestaurantInfoContainer({Key key, @required this.provider}) : super(key: key);

  final RestaurantsDetailsProvider provider;
  @override
  Widget build(BuildContext context) {
    print('provider => ${provider.storeDetailsData}');
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        children: [
          Divider(
            color: AppColors.mainColor.withOpacity(.3),
            thickness: 1.2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: AppColors.yellowColor,
                            size: 16,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            '4.0',
                            style: AppStyle.textStyle12
                                .copyWith(fontFamily: "Cairo"),
                          ),
                        ],
                      ),
                      Text(
                        '50 مشاركات ',
                        style: AppStyle.textStyle10
                            .copyWith(color: AppColors.blackColor),
                      ),
                    ],
                  )),
              Container(
                height: 50,
                width: 1,
                color: AppColors.mainColor.withOpacity(.5),
              ),
              Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.solidClock,
                            color: AppColors.mainColor,
                            size: 13,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            !provider.storeDetailsData.open ?? false
                                ? 'مفتوح حالياَ'
                                : 'مغلق',
                            style: AppStyle.textStyle12
                                .copyWith(fontFamily: "SemiBold"),
                          ),
                        ],
                      ),
                      /*     provider.storeDetailsData.open == false
                                    ? Text(
                                        'مواعيد العمل 9 ص ' + " | " + "1 م",
                                        style: AppStyle.textStyle10
                                            .copyWith(
                                                  color:
                              س                      AppColors.blackColor),
                                      )
                                    : Container(),*/
                    ],
                  )),
              Container(
                height: 50,
                width: 1,
                color: AppColors.mainColor.withOpacity(.5),
              ),
              Expanded(
                  flex: 2,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.locationColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        provider.storeDetailsData.city,
                        style: AppStyle.textStyle12.copyWith(
                          fontFamily: "SemiBold",
                        ),
                      ),
                    ],
                  )),
            ],
          ).addPaddingHorizontalVertical(vertical: 7, horizontal: 16),
          Divider(
            color: AppColors.mainColor.withOpacity(.3),
            thickness: 1.2,
          ),
        ],
      ),
    );
  }
}
