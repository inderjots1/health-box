import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

import 'onboarding2.dart';

import 'package:easy_localization/easy_localization.dart';

class OnBoarding1 extends StatefulWidget {
  String name,email,password,phone;

  OnBoarding1(this.name, this.email, this.password, this. phone);

  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  var whiteColor1= Colors.white;
  var text1= Colors.grey;
  var whiteColor2= Colors.white;
  var text2= Colors.grey;
  String gender ="";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(children: [
                  Image(
                    image: AssetImage(Assets.slide1),
                    height: 5.0,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SizedBox(height: 10.0,),
                  Image(
                    image: AssetImage(Assets.appLogo),
                    height: 60.0,
                    width: 100.0,
                  ),
                  SizedBox(height: 10.0,),
                  Text(LocaleKeys.key_tell_your_self,style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),).tr()
                ],),
              ),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: InkWell(onTap:(){
                                setState(() {
                                  whiteColor1 =greenColor;
                                  whiteColor2 =Colors.white;
                                  text2 =Colors.grey;
                                  text1 =Colors.green;
                                  gender ="1";
                                });
                              },child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    color: whiteColor1),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image(
                                    image: AssetImage(Assets.maleLogo),
                                  ),
                                ),
                              ),)),
                          Padding(padding: EdgeInsets.only(top: 15.0),child: Text(LocaleKeys.key_male,style: TextStyle(color: text1),).tr(),)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: InkWell(onTap:(){
                               setState(() {
                                 whiteColor2 =greenColor;
                                 whiteColor1 =Colors.white;
                                 text2 =Colors.green;
                                 text1 =Colors.grey;
                                 gender ="2";
                               });
                              },child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: whiteColor2),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image(
                                    image: AssetImage(Assets.femaleLogo),
                                  ),
                                ),
                              ))),
                          Padding(padding: EdgeInsets.only(top: 15.0),child: Text(LocaleKeys.key_female,style: TextStyle(color: text2),).tr(),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 5.0),
                  child: RoundedButtonWidget(
                    buttonColor: greenColor,
                    buttonText: LocaleKeys.key_next,
                    textColor: Colors.white,
                    onPressed: () {
                      if(gender.isEmpty){
                        Utils.toast("please select gender");
                      }else {
                        Utils.pushReplacement(context, OnBoarding2(widget.name,widget.email,widget.password,this.gender,widget.phone));
                      }
                    },
                    isIconDisplay: false,
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
