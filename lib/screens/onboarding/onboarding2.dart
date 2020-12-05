import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

import 'onboarding3.dart';

class OnBoarding2 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding2> {
  var currentIndex=-1;
  var list1 =[Assets.thumb,Assets.dumble,Assets.dumble,Assets.muscle];
  var list2 =["Feeling Confident","Body Builder","Being active","Gain Weight"];
  var list3 =["I want to be more confident in myself","I wantto be an look stronger","I want to feel energetic, fit and healthy","I want to gain Weight, I feel skinny"];

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
                      width: MediaQuery.of(context).size.width,
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
                      Strings.text_onboarding2,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(children: [
                Expanded(child: Container(),flex: 1,),
                Expanded(child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              child: Container(

                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                    color: currentIndex==index?greenColor:Colors.white),
                                child: Padding(padding: EdgeInsets.all(12.0),child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Image(
                                        image: AssetImage(list1[index]),
                                        width: 30.0,
                                        height: 30.0,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list2[index],
                                          style: TextStyle(
                                              color: currentIndex==index?Colors.white:Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          list3[index],
                                          style: TextStyle(
                                              color:currentIndex==index?Colors.white:Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.0),
                                        ),
                                      ],
                                    )
                                  ],
                                ),),
                              )));
                    }),flex: 4,),
                Expanded(child: Container(),flex: 1,)
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
                      Utils.pushReplacement(context, OnBoarding3());
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
