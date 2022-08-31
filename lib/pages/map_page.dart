import 'package:car_app_finder_mobile/common.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapPage extends StatelessWidget {
  final String url;
  const MapPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
          onPageStarted: (url) => {showLoading(context)},
          onPageFinished: (url) =>
              {ScaffoldMessenger.of(context).hideCurrentSnackBar()},
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: url),
    );
  }
}
