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
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../connect.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isSwitched = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChanged();
    /* if(context.locale==Locale('ar', 'DZ')){
      isSwitched = true;
    }else{
      isSwitched = false;
    }*/
  }

  isChanged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    print("sanjadsn ${sharedPreferences.getBool("language")}");
    if (sharedPreferences.getBool("language") != null) {
      isSwitched = sharedPreferences.getBool("language");
     setState(() {
     });
    }
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
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          color: Colors.white,
          child: Column(
            children: [_upperUI(), _bottomButtons()],
          ),
        ),
      ),
    ));
  }

  Widget _upperUI() {
    return Expanded(
        child: Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Image(
              image: AssetImage(Assets.appLogo),
              height: 60.0,
              width: 100.0,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Image(
            image: AssetImage(Assets.image_background),
            height: 200.0,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.key_welcome,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ).tr(),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    LocaleKeys.key_app_name,
                    style: TextStyle(fontSize: 16.0, color: greenColor),
                  ).tr(),
                  Text(
                    ",",
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ).tr(),
                ],
              )),
        )
      ],
    ));
  }

  /*======================================================== bottom buttons ==============================================*/

  Widget _bottomButtons() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: [
          mannual_login(),
          social_login(),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(Assets.language),
                  height: 30.0,
                  width: 30.0,
                ),
                SizedBox(
                  width: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      "Arbic",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          changeLanguage(isSwitched);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Text(
                      "English",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /*========================================================== sign with apple ============================================*/

  applebutton() {
    return RoundedButtonWidget(
      buttonColor: blueColor,
      buttonText: LocaleKeys.key_connect,
      textColor: grey,
      isIconDisplay: false,
      onPressed: () {
       // Utils.pushReplacement(context, OnBoarding1());
      },
      imageUrl: Assets.appleLogo,
    );
  }

  /*======================================================== social buttons ==============================================*/

  Widget social_login() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 15.0),
              height: 1.0,
              color: lightgrey,
            )),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Or Connect",
                style: TextStyle(color: lightgrey, fontSize: 15.0),
              ),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(right: 15.0),
              height: 1.0,
              color: lightgrey,
            )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(Assets.twitterLogo),
                  width: 40.0,
                  height: 40.0,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(Assets.appleLogo),
                  width: 40.0,
                  height: 40.0,
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: Image(
                  image: AssetImage(Assets.googleLogo),
                  width: 40.0,
                  height: 40.0,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget mannual_login() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 5.0, top: 10.0, bottom: 30.0),
          child: RoundedButtonWidget(
            buttonColor: grey,
            buttonText: LocaleKeys.key_google,
            textColor: Colors.white,
            isIconDisplay: false,
            onPressed: () {
              Utils.pushReplacement(context, RegisterScreen());
            },
            imageUrl: Assets.googleLogo,
          ),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 30.0),
          child: RoundedButtonWidget(
            buttonColor: greenColor,
            buttonText: LocaleKeys.key_twitter,
            textColor: Colors.white,
            isIconDisplay: false,
            onPressed: () {
              Utils.pushReplacement(context, LoginScreen());
            },
            imageUrl: Assets.twitterLogo,
          ),
        ))
      ],
    );
  }

  changeLanguage(bool isEnglishSelect) {
    if (isEnglishSelect) {
      context.locale = Locale('ar', 'DZ');
      isChange(true);
    } else {
      context.locale = Locale('en', 'US');
      isChange(false);
    }
  }

  isChange(bool bool) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("language", bool);
  }
}
