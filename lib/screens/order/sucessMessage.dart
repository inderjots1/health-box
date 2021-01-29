import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/screens/home/homeScreen.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';

class SucessMessage extends StatefulWidget {
  @override
  _SucessMessageState createState() => _SucessMessageState();
}

class _SucessMessageState extends State<SucessMessage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  _upperUI()],
              ),
            ),
          ),
        ));
  }

  Widget _upperUI() {
    return Expanded(
        child: Stack(
          children: [
            Align(alignment: Alignment.topRight,child: InkWell(onTap: (){
              Utils.pushRemove(context, HomeScreen());
            },child: Icon(Icons.clear),),),
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
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                Image(
                  image: AssetImage(Assets.image_background),
                  height: 200.0,
                ),
                  SizedBox(height: 20.0,),
                Text(LocaleKeys.key_congratulation,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 22.0),).tr(),
                SizedBox(height: 20.0,),
                Text(LocaleKeys.key_s1,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300, fontSize: 16.0),).tr(),
                SizedBox(height: 20.0,),
                Text(LocaleKeys.key_s2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300, fontSize: 16.0),).tr(),
              ],),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButtonWidget(
                buttonColor: greenColor,
                buttonText: LocaleKeys.key_calender,
                textColor: Colors.white,
                onPressed: () {
                  Utils.pushRemove(context, HomeScreen());
                },
                isIconDisplay: false,
              )
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
                onPressed: () {

                },
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
                onPressed: () {

                },
                imageUrl: Assets.twitterLogo,
              ),
            ))
      ],
    );
  }
}
