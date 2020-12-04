import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/widgets/button.dart';

class OnBoarding1 extends StatefulWidget {
  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
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
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: greenColor),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image(
                                    image: AssetImage(Assets.maleLogo),
                                  ),
                                ),
                              )),
                          Padding(padding: EdgeInsets.only(top: 15.0),child: Text("Male"),)
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
                              child: Container(
                                height: 200.0,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    color: greenColor),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Image(
                                    image: AssetImage(Assets.femaleLogo),
                                  ),
                                ),
                              )),
                          Padding(padding: EdgeInsets.only(top: 15.0),child: Text("Female"),)
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
                    buttonText: Strings.text_next,
                    textColor: Colors.white,
                    onPressed: () {},
                    isIconDisplay: false,
                  )),
            )
          ],
        ),
      ),
    ));
  }
}
