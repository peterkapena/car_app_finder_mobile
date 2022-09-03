import 'package:car_app_finder_mobile/common.dart';
import 'package:car_app_finder_mobile/models/tracker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatefulWidget {
  final Tracker tracker;
  const MapPage({super.key, required this.tracker});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // LocationData? _currentPosition;
  Location location = Location();
  String _url = "";
  // String _queryString = "";
  WebViewController? _webViewController;

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
      // var currentPosition = await location.getLocation();
      // _setQueryStr(currentPosition);
      location.onLocationChanged.listen((LocationData currentLocation) {
        _setQueryStr(currentLocation);
      });
    }
  }

  void _setQueryStr(LocationData? currentPosition) {
    if (currentPosition != null) {
      var url =
          "$mapUrl?fLatLng=${currentPosition.latitude},${currentPosition.longitude}&tLatLng=${widget.tracker.position}";

      if (url != _url) {
        setState(() {
          _url = url;
        });
        _webViewController?.loadUrl(_url);
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
