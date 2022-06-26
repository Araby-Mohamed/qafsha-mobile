/*
import 'package:afsha/Components/Style.dart';
import 'package:afsha/extensions/padding.dart';
import 'package:afsha/extensions/widget.dart';
import 'package:afsha/screen/restaurant_details/restaurant_details_provider.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/tools/Constants.dart';
import 'package:afsha/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SelectSubCategoryWidget extends StatefulWidget {
  SelectSubCategoryWidget(
      {@required this.selectedIndexCallBack, @required this.category, Key key})
      : super(key: key);

  ValueChanged<int> selectedIndexCallBack;
  CategoryModel category;
  @override
  _SelectSubCategoryWidgetState createState() =>
      _SelectSubCategoryWidgetState();
}

class _SelectSubCategoryWidgetState extends State<SelectSubCategoryWidget> {
  ValueNotifier<int> _selectedCatIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      restaurantsProvider.getStore(
        context: context,
        restaurantId: 1,
      );
      restaurantsProvider.getStoreDepartment(
          context: context,
          storeId: widget.idRestaurant,
          callback: (int departId) {
            selectedDepartmentIdNotifier.value = departId;
            print('deeeep id => ${departId}');
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<RestaurantsDetailsProvider>();

    return ValueListenableBuilder(
      valueListenable: _selectedCatIndex,
      builder: (BuildContext context, int selectedIndex, _) => provider.subCategoriesLoader
          ? horizontalShimmer(context: context)
          : SizedBox(
              height: 40.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: provider?.subCategoriesProductModel?.data?.map((e) {
                  int index =
                      provider?.subCategoriesProductModel?.data?.indexOf(e);
                  bool selected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      _selectedCatIndex.value = index;
                      widget.selectedIndexCallBack.call(
                          provider?.subCategoriesProductModel?.data[index].id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected
                              ? AppColors.mainColor.withOpacity(.8)
                              : Colors.white,
                          border: Border.all(color: AppColors.grayColor),
                          borderRadius: BorderRadius.circular(
                              Constants.APP_BORDER_RADIUS)),
                      height: 40.h,
                      child: Row(
                        children: [
                          if (e.image != null)
                            Image.asset(e.image).setWidth(20).setHeight(20),
                          SizedBox(
                            width: 4.w,
                          ),
                          Text(
                            e.title,
                            style:AppStyle.textStyle15,
                          ).setCenter(),
                        ],
                      ).addPaddingHorizontalVertical(horizontal: 5),
                    ).addPaddingOnly(right: 10),
                  );
                })?.toList(),
              ),
            ),
    );
  }
}
*/
