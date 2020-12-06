import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

import 'onboarding5.dart';

class OnBoarding4 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding4> {
  int _currentSelection = 0;
  Map<int, Widget> _children = {
    0: Text('      Ft      '),
    1: Text('      cm      '),
  };
  var text = "Ft";

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
                          image: AssetImage(Assets.slid4),
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
                          Strings.text_onboarding4,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 100,
                                        child: RoundedButtonWidget(
                                          buttonColor: greenColor,
                                          buttonText: "Skip",
                                          width: 100,
                                          textColor: Colors.white,
                                          onPressed: () {},
                                          isIconDisplay: false,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(width: 100.0,child: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        style: TextStyle(fontSize: 30),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.length < 3) {
                                            return 'a minimum of 3 characters is required';
                                          }
                                        },
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixText: text,
                                          suffixStyle: TextStyle(fontSize: 16),
                                        )),),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            MaterialSegmentedControl(
                              children: _children,
                              selectionIndex: _currentSelection,
                              borderColor: Colors.grey,
                              selectedColor: greenColor,
                              unselectedColor: Colors.white,
                              borderRadius: 20.0,
                              /*  disabledChildren: [
                            1
                          ],*/
                              onSegmentChosen: (index) {
                                setState(() {
                                  _currentSelection = index;
                                  if(index==0){
                                    text ="Ft";
                                  }else if(index ==1){
                                    text =" Cm";
                                  }
                                });
                              },
                            )
                          ],
                        ),
                        flex: 2,
                      ),

                    ],
                  ),
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
                          Utils.pushReplacement(context,OnBoarding5());
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
