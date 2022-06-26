import 'package:afsha/screen/%20pick_location/location_provider.dart';
import 'package:afsha/screen/contact_us/contact_us_provider.dart';
import 'package:afsha/screen/home_page/home_page_provider.dart';
import 'package:afsha/screen/login_screen/login_provider.dart';
import 'package:afsha/screen/notification/notification_provider.dart';
import 'package:afsha/screen/order_confirmation/order_confirmation_provider.dart';
import 'package:afsha/screen/order_status/order_status_provider.dart';
import 'package:afsha/screen/orders/order_provider.dart';
import 'package:afsha/screen/regstration_Screen/registration_provider.dart';
import 'package:afsha/screen/restaurant_details/res_details.dart';
import 'package:afsha/screen/restaurant_details/restaurant_details.dart';
import 'package:afsha/screen/restaurant_details/restaurant_details_provider.dart';
import 'package:afsha/screen/setting/setting_provider.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'SplashScreen.dart';
import 'screen/ edit_profile/profile_provider.dart';
import 'screen/captains_list/offer_provider.dart';
import 'screen/mobile_confirmation/mail_confirmation_provider.dart';
import 'screen/restaurants/restaurants_provider.dart';
import 'service/dio_helper.dart';
import 'service/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await setupLocators();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(
      value: HomePageProvider(),
    ),
    ChangeNotifierProvider.value(
      value: RestaurantsProvider(),
    ),
    ChangeNotifierProvider.value(
      value: RestaurantsDetailsProvider(),
    ),
    ChangeNotifierProvider.value(
      value: ContactUsProvider(),
    ),
    ChangeNotifierProvider.value(
      value: LocationProvider(),
    ),
    ChangeNotifierProvider.value(
      value: OrderConfirmationProvider(),
    ),
    ChangeNotifierProvider.value(
      value: OrderProvider(),
    ),
    ChangeNotifierProvider.value(
      value: OrderStatusProvider(),
    ),
    ChangeNotifierProvider.value(
      value: LoginProvider(),
    ),
    ChangeNotifierProvider.value(
      value: RegistrationProvider(),
    ),
    ChangeNotifierProvider.value(
      value: MailConfirmationProvider(),
    ),
    ChangeNotifierProvider.value(
      value: EditProfileProvider(),
    ),
    ChangeNotifierProvider.value(
      value: OfferProvider(),
    ),
    ChangeNotifierProvider.value(
      value: SettingProvider(),
    ),
    ChangeNotifierProvider.value(
      value: NotificationProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@drawable/launcher');
    var iOS = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings);
    setupFireBaseMessaging();
  }

  setupFireBaseMessaging() async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    ///Request notifications permission
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        print("remote Message : ${message.data}");
      }
    }).catchError((e) {});

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'com.devnine.afsha', // id
      'com.devnine.afsha', // title// description
      'com.devnine.afsha', // title// description
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      print(
          "mess  title :  ${message.notification.title}}, mess body : ${message.notification.body}");
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.name,
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      print(message.data.toString());
    });

    Future<void> _firebaseMessagingBackgroundHandler(
        RemoteMessage message) async {
      await Firebase.initializeApp();
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    getUserToken();
  }

  getUserToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print("user token main => $fcmToken");
    sL<SharedPrefService>().saveDevicesToken(fcmToken);
  }

  // designSize: const Size(375, 812),
  String fcmToken;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: [Locale("ar", "AE")],
          locale: Locale("ar", "AE"),
          title: 'قفشه',
          theme: ThemeData(
              fontFamily: "Cairo",
              accentColor: Colors.white,
              primaryColor: Colors.pink[800],
              tabBarTheme: TabBarTheme(
                labelColor: Colors.pink[800],
                labelStyle:
                    TextStyle(color: Colors.pink[800]), // color for text
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.red)),

                // accentColor: Colors.cyan[600]
              )),
          // home: MainPage(index: 0,)
          home: SplashScreen()),
    );
  }
}
