import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:afsha/screen/login_screen/login_screen.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'OnBoardingPageOne.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentPage = 0;
  List<Widget> _pages = [
    OnBoardingBody(
      title: 'أطلب',
      mess: 'طعامك طازج بخيارات متنوعة لطلب أكثر سهولة',
      imagePath: Resources.ON_BOARDING_MAN,
    ),
    OnBoardingBody(
      title: 'أختار',
      mess: 'التفاوض مع مناديب التوصيل و أختيار العرض الأنسب لك',
      imagePath: Resources.ON_BOARDING_MAN22,
    ),
    OnBoardingBody(
      title: 'نصلك',
      mess: 'بشكل سريع وآمن وأنت بمكانك',
      imagePath: Resources.ON_BOARDING_MAN3,
    ),
  ];

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 4.0,
      width: isActive ? 30.0 : 30.0,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.mainColor
            : AppColors.mainColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  void initState() {
    _buildPageIndicator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      key: scaffoldKey,
      children: <Widget>[
        PageView(
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          controller: _pageController,
          children: _pages,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            SizedBox(
              height: 20.h,
            ),
            if (_currentPage == 2)
              _buildButton()
            else
              SizedBox(
                height: 76.h,
              )
          ],
        ).setCenter().addPaddingOnly(bottom: context.bottomSafeArea + 30),
        Positioned(
          child: CupertinoButton(
            child: Text(
              'تخطي',
              style: AppStyle.textStyle15,
            ),
            onPressed: () {
              NavigatorX.push(
                  context,
                  MainPage(
                    index: 0,
                  ));
            },
          ),
          top: 50,
          left: 5,
        )
      ],
    );
    // return NetworkConnectionMessage();
  }

  _buildButton() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            EduButton(
              onPressed: () {
                print('done order');
                NavigatorX.push(
                    context,
                    MainPage(
                      index: 0,
                    ));
              },
              width: 200,
              bgColor: MaterialStateProperty.all(AppColors.mainColor),
              title: 'ابدأ الآن',
              style: AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: () {
              NavigatorX.push(context, LoginScreen());
            },
            child: Text(
              'تسجيل الدخول',
              style: AppStyle.textStyle15
                  .copyWith(decoration: TextDecoration.none),
            ))
      ],
    );
  }
}
