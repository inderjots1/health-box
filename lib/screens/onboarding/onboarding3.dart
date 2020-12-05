import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

class OnBoarding3 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding3> {
  var currentIndex = -1;
  var list1 = [Assets.thumb, Assets.dumble, Assets.dumble, Assets.muscle];
  var list2 = [
    "Feeling Confident",
    "Body Builder",
    "Being active",
    "Gain Weight"
  ];
  var list3 = [
    "I want to be more confident in myself",
    "I wantto be an look stronger",
    "I want to feel energetic, fit and healthy",
    "I want to gain Weight, I feel skinny"
  ];

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
                          Strings.text_onboarding3,
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
                          Utils.pushReplacement(context, Strings.text_onboarding4);
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
