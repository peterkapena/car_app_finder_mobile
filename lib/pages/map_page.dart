import 'dart:async';

import 'package:car_app_finder_mobile/common.dart';
import 'package:car_app_finder_mobile/models/car.dart';
import 'package:car_app_finder_mobile/services/car_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  final Car car;
  final String initialCoord;
  const MapPage({super.key, required this.car, required this.initialCoord});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Location location = Location();
  String _url = "";
  WebViewController? _webViewController;
  final CarApiService _carApiService = CarApiService();
  String _carLatLng = "";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getLoc();
  }

  _getLoc() async {
    if (await _locationIsEnabledAndGranted()) {
      // const period = Duration(seconds: 5);

      // Timer.periodic(
      //     period,
      //     (Timer t) => {
      //           _carApiService
      //               .getRecentCoord(widget.car.trackerSerialNumber)
      //               .then((value) {
      //             if (value.isNotEmpty) {
      //               _carLatLng = value;
      //               setState(() {});
      //             }
      //           })
      //         });

      location.onLocationChanged.listen((LocationData currentLocation) {
        _setQueryStr(currentLocation);
      });
    }
  }

  void _setQueryStr(LocationData? currentPosition) async {
    if (currentPosition != null) {
      _carLatLng =
          await _carApiService.getRecentCoord(widget.car.trackerSerialNumber);

      var url =
          "$mapUrl?fLatLng=${currentPosition.latitude},${currentPosition.longitude}&tLatLng=$_carLatLng";

      if (url != _url) {
        try {
          setState(() {
            if (kDebugMode) print(url);
            _url = url;
          });
          _webViewController?.loadUrl(_url);
        } catch (e) {
          if (kDebugMode) print(e.toString());
        }
      }
    }
  }

  Future<bool> _locationIsEnabledAndGranted() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _url.isEmpty
          ? Container()
          : WebView(
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onPageStarted: (url) => {showLoading(context)},
              onPageFinished: (url) =>
                  {ScaffoldMessenger.of(context).hideCurrentSnackBar()},
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: _url),
    );
  }
}
