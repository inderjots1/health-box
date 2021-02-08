import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/screens/order/Address.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';

class SubscriptionPlan extends StatefulWidget {
  String programEnDescribe,
      programArDescribe,
      programId,
      programDiscount,
      programDuration,
      programCost,
      programTitleEn,
      programTitleAr;

  SubscriptionPlan(
      this.programEnDescribe,
      this.programArDescribe,
      this.programId,
      this.programDiscount,
      this.programDuration,
      this.programCost,
      this.programTitleEn,
      this.programTitleAr);

  @override
  _SubscriptionPlanState createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Image(
              image: AssetImage(
                Assets.backgroundImage1,
              ),
              fit: BoxFit.fill,
              height: 350.0,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 55.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              LocaleKeys.key_subscription,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ).tr(),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Image(
                          image: AssetImage(Assets.cartton),
                        ),
                      ),
                      Expanded(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.key_is_time,
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                          ).tr(),
                          Text(
                            EasyLocalization.of(context).locale.languageCode ==
                                    "en"
                                ? widget.programTitleEn
                                : widget.programTitleAr,
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
                          ).tr()
                        ],
                      ))
                    ],
                  ),
                  SizedBox(height: 50.0),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 140.0,
                            padding: EdgeInsets.all(10.0),
                            margin: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(
                                color: Colors.grey[200],
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    "Program Duration: ${widget.programDuration}"),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Cost: ${widget.programCost}"),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Discount: ${widget.programDiscount}")
                              ],
                            ),
                          ),
                        ),
                        /* Expanded(
                          child: Container(
                            height: 180.0,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0)),
                                border: Border.all(
                                  color: greenColor,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                color: greenColor),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.0),
                                          topRight: Radius.circular(15.0)),
                                      border: Border.all(
                                        color: greenColor,
                                        style: BorderStyle.solid,
                                        width: 1.0,
                                      ),
                                      color: yellow),
                                  child: Text(
                                    LocaleKeys.key_free_trial,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 12.0),
                                  ).tr(),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  LocaleKeys.key_week,
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                ).tr(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                  "20Kd",
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                  ),
                                  child: Text(
                                    LocaleKeys.key_week_detail,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.white),
                                  ).tr(),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 140.0,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              border: Border.all(
                                color: Colors.grey[200],
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(LocaleKeys.key_month_three).tr(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("300Kd"),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text("Save 25%")
                              ],
                            ),
                          ),
                        ),*/
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                        EasyLocalization.of(context).locale.languageCode == "en"
                            ? widget.programEnDescribe
                            : widget.programArDescribe),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: EdgeInsets.all(15.0),
                child: RoundedButtonWidget(
                  buttonColor: greenColor,
                  buttonText: LocaleKeys.key_subscribe,
                  textColor: Colors.white,
                  onPressed: () async {
             Navigator.push(
                        context, MaterialPageRoute(builder: (BuildContext) =>  Payment(widget.programId, widget.programCost,
                        widget.programDuration)));




                  },

                  isIconDisplay: false,
                )),
          )
        ],
      ),
    ));
  }
}
