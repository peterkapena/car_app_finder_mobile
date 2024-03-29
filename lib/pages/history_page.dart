import 'package:car_app_finder_mobile/common.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HistoryPage extends StatefulWidget {
  final String trackerId;
  const HistoryPage({
    super.key,
    required this.trackerId,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Location location = Location();

  @override
  void dispose() {
    super.dispose();
  }

  String _getUrl() {
    var url = "${mapUrl}history/?c=${widget.trackerId}";
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
          onPageStarted: (url) => {showLoading(context)},
          onPageFinished: (url) =>
              {ScaffoldMessenger.of(context).hideCurrentSnackBar()},
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: _getUrl()),
    );
  }
}
