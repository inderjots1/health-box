import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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

  static  void push (context,route){
    Navigator.push(context, CupertinoPageRoute(builder: (context)=>route));
  }

  static void popAndpush (context ,route){
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
      statusBarBrightness: Brightness.dark ,
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

 /* *//*---------------------------------------- toast ------------------------------------*//*

  static void toast(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

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

  static void snackBar(String string){
    SnackBar(
        content: Text(string),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
          },
        ));
  }

  static void closeDialog(context){
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

  static void  hideWidgetAuction(viewVisibleAuction) {

      viewVisibleAuction = false;

  }

}
