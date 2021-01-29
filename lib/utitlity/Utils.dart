import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:health_box/constants/assets.dart';
import 'package:easy_localization/easy_localization.dart';

class Utils {
  /*---------------------------- go to next route -------------------------*/
  static void pushReplacement(context, dartName) {
    Timer(
        Duration(milliseconds: 200),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (BuildContext) => dartName)));
  }

  static void finishScreen(context) {
    Navigator.pop(context, true);
  }

  static void pushScreen(context, name) {
    Navigator.of(context).pushReplacementNamed(name);
  }

  static void push(context, route) {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => route));
  }

  static void popAndpush(context, route) {
    Navigator.popAndPushNamed(context, route);
  }

  static void pushRemove(context, route) {
    Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => route),
        (Route<dynamic> route) => false);
  }

  /*------------------------- transparent status bar ---------------------*/

  static void transparentStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  /*--------------------------- hide status bar or Full Screen --------------------------*/

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
  }

  static void popbeforeAll(context, name) {
    Navigator.popUntil(context, ModalRoute.withName(name));
  }

  static void toast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }
  /* */ /*---------------------------------------- toast ------------------------------------*/ /*



  static onBackPressed(context) {
    Navigator.pop(context, true);
    //  Navigator.pop(context);
  }

  static String netStatus(Map source) {
    String string;
    switch (source.keys.toList()[0]) {
      case ConnectivityResult.none:
        string = "Offline";
        break;
      case ConnectivityResult.mobile:
        string = "Mobile: Online";
        break;
      case ConnectivityResult.wifi:
        string = "WiFi: Online";
    }
    return string;
  }*/

  static void hideKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static void snackBar(String string) {
    SnackBar(
        content: Text(string),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ));
  }

  static void closeDialog(context) {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static void showWidget(viewVisible) {
    viewVisible = true;
  }

  static void showWidgetAuction(viewVisibleAuction) {
    viewVisibleAuction = true;
  }

  static void hideWidget(viewVisible) {
    viewVisible = false;
  }

  static void hideWidgetAuction(viewVisibleAuction) {
    viewVisibleAuction = false;
  }

  static cardView(String image, String heading, String subheading,
      Color cardcolor, Color textColor, String price, String Days, String programTypeEn) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.grey[400]),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "${Days} day",
                            style:
                            TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Image(
                            image: AssetImage(
                              Assets.user_flow,
                            ),
                            width: 25.0,
                            height: 22.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            programTypeEn,
                            style:
                            TextStyle(fontSize: 16.0, color: Colors.white),
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Text(
                            "Price : ${price}",
                            textAlign: TextAlign.end,
                            style:
                            TextStyle(fontSize: 16.0, color: Colors.white),
                          )

                        ],
                      ),
                      SizedBox(width: 10.0,),
                      Row(crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

    ],)
                    ],
                  ),
                ),
              )),
        ),
        Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: cardcolor),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Image(
                        image: AssetImage(image),
                        width: 30.0,
                        height: 30.0,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            heading,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0),
                          ).tr(),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            subheading,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.0),
                          ).tr(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
