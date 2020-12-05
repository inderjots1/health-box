import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

import 'onboarding6.dart';

class OnBoarding5 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding5> {


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
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(Assets.slide2),
                          height: 5.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Image(
                          image: AssetImage(Assets.appLogo),
                          height: 60.0,
                          width: 100.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          Strings.text_onboarding5,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(children: [
                    Expanded(child: Container(), flex: 1,),
                    Expanded(child: Stack(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 5.0),
                            child: Container(width: 100,child: RoundedButtonWidget(
                              buttonColor: greenColor,
                              buttonText: "Skip",width: 100,
                              textColor: Colors.white,
                              onPressed: () {},
                              isIconDisplay: false,
                            ),)),
                      ),Padding(padding: EdgeInsets.only(left: 150),child:  Align(alignment: Alignment.center,
                        child: TextFormField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                          style: TextStyle(fontSize: 30),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.length < 3) {
                              return
                                'a minimum of 3 characters is required';
                            }
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,)
                        ), ),)
                    ],), flex: 1,),
                    Expanded(child: Container(), flex: 1,)
                  ],),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: RoundedButtonWidget(
                        buttonColor: greenColor,
                        buttonText: Strings.text_next,
                        textColor: Colors.white,
                        onPressed: () {
                          Utils.pushReplacement(context, OnBoarding6());
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
