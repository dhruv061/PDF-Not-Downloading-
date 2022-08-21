import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:gtu_all_in_one/Pages/HomePage.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/LoadingIndicator.dart';
import 'InternetErrorPage.dart';

class CircularPage extends StatefulWidget {
  @override
  State<CircularPage> createState() => _CircularPageState();
}

class _CircularPageState extends State<CircularPage> {
  //method for check internet conection
  void checkInternetConnection(ConnectivityResult internetConnection) {
    // inside if condition is true then Internet is off otherwise is on
    if (internetConnection == ConnectivityResult.none) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => InternetErrorPage()));
    }
  }

  //this is also for checking internet
  Future<void> CheckInternert() async {
    //for check internet Conection
    final internetConnection = await Connectivity().checkConnectivity();
    checkInternetConnection(
      internetConnection,
    );
  }

  //for indicatroe (Loader)
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          WebView(
            key: _key,
            initialUrl: "https://www.gtu.ac.in/Circular.aspx",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
                CheckInternert();
              });
            },
          ),
          isLoading ? Container(child: LoadingIndicator()) : Stack(),
        ],
      ),
    );
  }
}
