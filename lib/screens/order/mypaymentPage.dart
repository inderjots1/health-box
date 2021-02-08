import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/BuyResponseModel.dart';
import 'package:health_box/model/response_model/addressResponseModel.dart';
import 'package:health_box/model/response_model/feedbackResponse.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/screens/order/sucessMessage.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:webview_flutter/webview_flutter.dart';

import '../../constant.dart';

class MyPaymentPage extends StatefulWidget {
  String paymentredirectUrl;
  MyPaymentPage(this.paymentredirectUrl);

  @override
  State<StatefulWidget> createState() {
    return AddNewAdressState();
  }
}

class AddNewAdressState extends State<MyPaymentPage> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              LocaleKeys.key_payment,
              style: TextStyle(color: Colors.black),
            ).tr(),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          body: Builder(builder: (BuildContext context) {
            return WebView(
              initialUrl:widget.paymentredirectUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              // TODO(iskakaushik): Remove this when collection literals makes it to stable.
              // ignore: prefer_collection_literals
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                print('Page started loading: $url');
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
                print("urlsplit ${url.split("?")[0]}");
                if(url.split("?")[0]=="http://healthyboxq8.com/api/webservices/api/payment_upay_api.php"){
Navigator.pop(context,url);
                }
              },
              gestureNavigationEnabled: true,
            );
          }),),
    );
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

}
