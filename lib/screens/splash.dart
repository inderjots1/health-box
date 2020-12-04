import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/screens/onboarding/onboarding1.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Text(
                  Strings.text_welcome,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
                Text(
                  Strings.text_app_name,
                  style: TextStyle(fontSize: 16.0, color: greenColor),
                )
              ],)),
        )
      ],
    ));
  }

  /*======================================================== bottom buttons ==============================================*/

  Widget _bottomButtons() {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: Column(
        children: [applebutton(), social_login()],
      ),
    );
  }

  /*========================================================== sign with apple ============================================*/

  applebutton() {
    return RoundedButtonWidget(
      buttonColor: blueColor,
      buttonText: Strings.text_apple,
      textColor: Colors.white,
      isIconDisplay: true,
      onPressed: () {
        Utils.pushReplacement(context, OnBoarding1());
      },
      imageUrl: Assets.appleLogo,
    );
  }

  /*======================================================== social buttons ==============================================*/

  Widget social_login() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(right: 5.0, top: 10.0, bottom: 30.0),
          child: RoundedButtonWidget(
            buttonColor: yellowColor,
            buttonText: Strings.text_google,
            textColor: Colors.white,
            isIconDisplay: true,
            onPressed: () {},
            imageUrl: Assets.googleLogo,
          ),
        )),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(left: 5.0, top: 10.0, bottom: 30.0),
          child: RoundedButtonWidget(
            buttonColor: skyBlueColor,
            buttonText: Strings.text_twitter,
            textColor: Colors.white,
            isIconDisplay: true,
            onPressed: () {},
            imageUrl: Assets.twitterLogo,
          ),
        ))
      ],
    );
  }
}
