import 'dart:convert';
import 'dart:io';
import 'package:afsha/model/offer_response_model.dart';
import 'package:afsha/model/pusher_response.dart';
import 'package:afsha/model/services_response_model.dart';
import 'package:afsha/screen/captains_list/captains_list.dart';
import 'package:afsha/screen/main_page_screen.dart';
import 'package:afsha/screen/mobile_confirmation/mail_confirmation.dart';
import 'package:afsha/service/dio_helper.dart';
import 'package:afsha/service/service_locator.dart';
import 'package:afsha/service/shared_prefrence.dart';
import 'package:afsha/tools/displayCustomLoader.dart';
import 'package:afsha/utils/components.dart';
import 'package:afsha/utils/endpoints.dart';
import 'package:afsha/utils/navigatorX.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pusher_client/pusher_client.dart';

class OfferProvider extends ChangeNotifier {
  bool _offerLoader = true;

  bool get offerLoader => _offerLoader;
  set setOfferLoader(bool newVale) {
    _offerLoader = newVale;
    notifyListeners();
  }

  List<OfferData> _offerList;
  List<OfferData> get offerList => _offerList;
  set setOfferList(List<OfferData> newList) {
    _offerList = newList;
    notifyListeners();
  }

  Future<List<OfferData>> getOffer({BuildContext context}) async {
    _offerLoader = true;
    Response response = await DioHelper.getData(
        url: EndPoints.offerList(), withCache: true, withAuth: true);
    _offerLoader = false;
    if (response?.statusCode == HttpStatus.ok ||
        response?.statusCode == HttpStatus.created) {
      OfferResponseModel offerResponseModel =
          OfferResponseModel.fromJson(response.data);
      setOfferList = offerResponseModel.data;
    } else if (response.statusCode == HttpStatus.badRequest) {
      for (String mess in response.data['error']) {
        showToast(message: mess);
      }
    } else {}
    print(" store List length  ${_offerList.length}");
    return _offerList;
  }

  void approveOffer({
    @required BuildContext context,
    @required int offerId,
  }) async {
    displayCustomCircular(context);
    var body = {
      "offer_id": offerId,
    };
    Response response =
        await DioHelper.pastData(url: EndPoints.approveOffer(), data: body);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      showToast(message: response.data['message']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(
                    index: 1,
                  )));
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = '';
      response.data['errors'].forEach((k, v) {
        for (String mess in v) {
          error += mess + "\n";
        }
      });
      showFlushBar(context: context, message: error);
    } else {}
  }

  PusherClient pusherClient;
  List<PusherResponse> _captainList = <PusherResponse>[];
  List<PusherResponse> get captainList => _captainList;
  set setNewCaptain(PusherResponse newItem) {
    _captainList.add(newItem);
    notifyListeners();
  }

  Future<void> initPusher({@required BuildContext context}) async {
    print('init pusher');
    print('logged in user id pusher => ${sL<SharedPrefService>().getUserId()}');
    if (pusherClient != null) return;
    pusherClient = PusherClient(
      'd4c55854258bf8f86b94',
      PusherOptions(
        cluster: 'eu',
        auth: PusherAuth(
          'https://qafshah.com.sa/api/user/v1/broadcasting/auth',
          headers: {
            'access-key':
                'GrU#}?a}^]8`#AbR3pRU+Apf%Kw[@]yp5{2X^}N*4\$#vCtF4_wW\$\$*!tDmq3',
            'Authorization': 'bearer ${sL<SharedPrefService>().getUserToken()}',
          },
        ),
      ),
      enableLogging: true,
    );
    await pusherClient.connect();
    Channel channel = pusherClient.subscribe(
        'private-qafsha-channel.${sL<SharedPrefService>().getUserId()}');
    channel.bind('offer_event', (PusherEvent event) async {
      if (event.data != null) {
        PusherResponse pusherResponse;
        pusherResponse = PusherResponse.fromJson(json.decode(event.data));
        setNewCaptain = pusherResponse;
        if (_captainList.length == 1) {
          NavigatorX.push(context, CaptainsList());
          return;
        }
      }
    });
  }

  void cancelOffer({
    @required BuildContext context,
    @required int orderId,
    @required String reasonForCancellation,
    @required String comment,
  }) async {
    displayCustomCircular(context);
    var body = {
      "comment": comment,
      "reason_for_cancellation": reasonForCancellation,
      "order_id": orderId,
    };
    Response response =
        await DioHelper.pastData(url: EndPoints.cancelOffer(), data: body);
    closeCustomCircular(context);
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      showToast(message: response.data['message']);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage(
                    index: 0,
                  )));
    } else if (response.statusCode == HttpStatus.unprocessableEntity) {
      String error = '';
      response.data['errors'].forEach((k, v) {
        for (String mess in v) {
          error += mess + "\n";
        }
      });
      showFlushBar(context: context, message: error);
    } else {}
  }
}
