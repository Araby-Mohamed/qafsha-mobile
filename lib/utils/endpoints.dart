import 'package:flutter/cupertino.dart';

class EndPoints {
  static const String REGISTRATION = '/auth/register';
  static const String LOGIN = '/auth/login';
  static const String devices = '/devices/store';
  static const String LOGOUT = '/auth/logout';
  static const String verify = '/auth/verify';
  static const String messages = '/messages/send';
  static const String profile = '/profile';
  static const String setting = '/setting';
  static const String updateProfile = '/profile/update';
  static const String setLocation = '/location/set';

  static String services({@required int pageNumber}) =>
      '/services?page=$pageNumber';
  static String stores({@required int pageNumber, @required int idServices}) =>
      '/stores?page=${pageNumber == null ? 1 : pageNumber}&service_id=$idServices';
  static String search({@required int pageNumber, String title}) =>
      '/stores/search?store=$title&page=$pageNumber';
  static String storesDetails({@required int restaurantId}) =>
      '/stores/$restaurantId';
  static String productAdditionEdit({@required int restaurantId}) =>
      '/cart/store/product_addition';
  static String storesDepartments({@required int storeId}) => '/departments?store_id=$storeId';
  static String productAndFastFoodDetails(
          {@required int storeId, @required int storeDepartmentId, @required int page}) =>
      '/products?store_department_id=$storeDepartmentId&store_id=$storeId&page=$page';
  static String productDetails({@required int productsId}) =>
      '/products/$productsId';
  static String cardDelete({@required int cardDeleteId}) =>
      '/cart/delete/$cardDeleteId';
  static String doneOrder() => '/order/store';
  static String setCart() => '/cart/store';
  static String getCart() => '/cart';
  static String getCartUpdate() => '/cart/update';
  static String beforeConform() => '/order/before-confirm';
  static String order() => '/order';
  static String orderDetails({@required int orderId}) => '/order/$orderId';
  static String offerList() => '/offer';
  static String approveOffer() => '/offer/approve';
  static String cancelOffer() => '/order/cancel';
  static String receivedOrder = '/order/received_confirm';
  static String notifications = '/notifications';
  static String received() => '/order/received';
}
