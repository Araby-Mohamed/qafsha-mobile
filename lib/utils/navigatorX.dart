import 'package:afsha/screen/restaurant_details/restaurant_details.dart';
import 'package:flutter/material.dart';

class NavigatorX {
 static int restaurantId;
  static Widget _lastScreen;
  static Widget _lastScreen2;

  // first screen
  static void pushToLastScreen(BuildContext context) {
    push(context, _lastScreen);
  }

  static void pushToLast2Screen(BuildContext context) {
    push(context, RestaurantDetails(idRestaurant: restaurantId));
  }

  static void push(BuildContext context, Widget screen) {
    _lastScreen = screen;
    _lastScreen2 = _lastScreen;
    print('_lastScreen2 => $_lastScreen2');
    print('_lastScreen => $_lastScreen');
    Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (context) => screen,
        ));
  }
}
