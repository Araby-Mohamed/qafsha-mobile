import 'dart:async';

import 'package:afsha/Components/Style.dart';
import 'package:afsha/Components/Widget/EduButton.dart';
import 'package:afsha/Components/Widget/ProfilePageTextFileds.dart';
import 'package:afsha/Components/resources.dart';
import 'package:afsha/tools/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:afsha/extensions/extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'location_provider.dart';

class PickLocation extends StatefulWidget {
  @override
  _PickLocationState createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _currentLocation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mapProvider = context.watch<LocationProvider>();
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'اختر موقعك',
                style:
                    AppStyle.textStyle15.copyWith(color: AppColors.mainColor),
              ),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close))
            ],
          ).addPaddingOnly(right: 16, top: 10, bottom: 10),
          Container(
              color: AppColors.blackColor,
              width: context.width,
              height: 450.h,
              child: _hallMapLocationContainer()),
          CustomTextField(
            enabled: false,
            prefixIcon: IconButton(
                icon: FaIcon(FontAwesomeIcons.mapPin),
                color: AppColors.mainColor,
                onPressed: () {
                  print("Pressed");
                }),
            hintText: mapProvider.address ?? 'ادخل موقعك',
          ).addPaddingHorizontalVertical(vertical: 10, horizontal: 16),
          Text(
            'ادخل موقعك بالتفصيل',
            style: AppStyle.textStyle12.copyWith(color: AppColors.blackColor),
          ).addPaddingHorizontalVertical(vertical: 5, horizontal: 16),
          CustomTextField(
            controller: _currentLocation,
            prefixIcon: Icon(
              Icons.location_on,
              color: AppColors.locationColor,
            ),
            hintText: 'اكتب موقعك بالتفصيل',
          ).addPaddingHorizontalVertical(vertical: 10, horizontal: 16),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EduButton(
                onPressed: () {
                  context.read<LocationProvider>().locationApi(
                        context: context,
                        address: _currentLocation.text,
                      );
                },
                width: context.width * 0.5,
                bgColor: MaterialStateProperty.all(AppColors.mainColor),
                title: 'تأكيد الموقع',
                style: AppStyle.textStyle15.copyWith(color: AppColors.whiteColor),
              ),
            ],
          ).addPaddingOnly(bottom: context.bottomSafeArea + 30)
        ],
      ),
    );
  }

  _hallMapLocationContainer() {
    return Consumer<LocationProvider>(
      builder: (context, locationProvider, child) {
        return Container(
          height: MediaQuery.of(context).size.height * .4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                  markers: locationProvider.markers,
                  onTap: (latlang) {
                    locationProvider.setLat = latlang.latitude;
                    locationProvider.setLng = latlang.longitude;
                    locationProvider.getAddressFromLatLng(context);
                    locationProvider.drawPinOnMapCreated(
                        lat: latlang.latitude.toString(),
                        lng: latlang.longitude.toString(),
                        mapController: _controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                        double.parse(locationProvider.lat.toString()),
                        double.parse(locationProvider.lng.toString())),
                  ),
                  mapType: MapType.normal,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    locationProvider.drawPinOnMapCreated(
                        lat: locationProvider.lat.toString(),
                        lng: locationProvider.lng.toString(),
                        mapController: _controller);
                  }),
              // myLocationEnabled: true,
            ],
          ),
        );
      },
    );
  }
}
