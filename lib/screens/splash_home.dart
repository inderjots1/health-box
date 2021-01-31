import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/screens/authentication/login.dart';
import 'package:health_box/screens/authentication/register.dart';
import 'package:health_box/screens/home/homeScreen.dart';
import 'package:health_box/screens/onboarding/onboarding1.dart';
import 'package:health_box/screens/splash.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connect.dart';

class SplashHome extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashHome>with SingleTickerProviderStateMixin {
  var islogin;
  AnimationController _controller;
  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    iswork();
  }



  iswork() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      islogin = sharedPreferences.getBool(LocalStorage.isLogin);
    });
    Timer.periodic(Duration(seconds: 3), (timer) {
      if(islogin==true){
        Utils.pushRemove(context, HomeScreen());
        timer.cancel();
      }else{
        Utils.pushRemove(context, SplashScreen());
        timer.cancel();
      }
    });
  }


  @override
  void dispose() {
    // checkInternet().listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_upperUI(),],
          ),
        ),
      ),
    ));
  }

  Widget _upperUI() {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
  /*  Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: Image(
        image: AssetImage(Assets.appLogo),
        height: _controller.value*60,
        width: _controller.value*100,
      ),
    ),*/

    Image(
      image: AssetImage(Assets.image_background),
      height: _controller.value*200,
    ),
        SizedBox(height: 30.0,),
        Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.key_welcome,
                  style: TextStyle(fontSize: 20.0, color: Colors.black),
                ).tr(),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  LocaleKeys.key_app_name,
                  style: TextStyle(fontSize: 20.0, color: greenColor),
                ).tr(),

              ],
            ))
      ],
    );
  }

}
