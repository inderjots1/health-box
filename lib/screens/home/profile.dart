import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';

import 'package:health_box/screens/order/myOrder.dart';
import 'package:health_box/screens/order/sucessMessage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  bool isSwitched1 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChanged();
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteLIGHT,
      body: SingleChildScrollView(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          _profileHeader(),
          _about(),_supportUs()
        ],
      ),),
    );
  }

  Widget _profileHeader() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(80.0),
            child: Image(
              image: AssetImage(Assets.avtar),
              height: 80.0,
              width: 80.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Abdullah Alajmi",
            style: TextStyle(
                fontSize: 22, color: greenColor, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Freeslab88@gmail.com",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 10.0,
              ),
              Image(
                image: AssetImage(Assets.edit_icon),
                height: 20.0,
                width: 20.0,
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(Assets.phone),
                height: 25.0,
                width: 25.0,
              ),
              SizedBox(
                width: 8.0,
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border.all(color: greenColor, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(
                  children: [
                    Text(
                      "50228866",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Image(
                      image: AssetImage(Assets.edit_icon),
                      height: 15.0,
                      width: 15.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border.all(color: greenColor, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(
                  children: [
                    Text(
                      "80Kg",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Image(
                      image: AssetImage(Assets.edit_icon),
                      height: 15.0,
                      width: 15.0,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    border: Border.all(color: greenColor, width: 1.5),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: Row(
                  children: [
                    Text(
                      "170cm",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Image(
                      image: AssetImage(Assets.edit_icon),
                      height: 15.0,
                      width: 15.0,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

 Widget _about() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              LocaleKeys.key_about,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ).tr(),
          ),
          SizedBox(height: 15.0,),
          Card(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Assets.subscription),
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Text(
                        LocaleKeys.key_my_plan,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ).tr()),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 20.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
               InkWell(onTap:(){
                Utils.pushReplacement(context,  MyOrder());
               },child:  Container(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     Image(
                       image: AssetImage(Assets.history),
                       height: 40.0,
                       width: 40.0,
                     ),
                     SizedBox(
                       width: 10.0,
                     ),
                     Expanded(
                         child: Text(
                          LocaleKeys.key_order_history,
                           style: TextStyle(
                               fontSize: 16,
                               color: Colors.grey,
                               fontWeight: FontWeight.w400),
                         ).tr()),
                     Icon(
                       Icons.arrow_forward_ios_sharp,
                       size: 20.0,
                       color: Colors.grey,
                     )
                   ],
                 ),
               ),),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Assets.language),
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            LocaleKeys.key_arbic,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ).tr()),
                          Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              setState(() {
                                isSwitched = value;
                                changeLanguage(isSwitched);
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: Colors.lightGreenAccent,
                            activeColor: Colors.green,
                          ),
                          SizedBox(
                            width: 15.0,
                          ),
                          Expanded(
                              child: Text(
                            "English",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          )),
                        ],
                      )),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Assets.notification),
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Text(
                            LocaleKeys.key_notification,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ).tr()),
                      Switch(
                        value: isSwitched1,
                        onChanged: (value) {
                          setState(() {
                            isSwitched1 = value;
                            print(isSwitched1);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _supportUs() {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
            LocaleKeys.key_support,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ).tr(),
          ),
          SizedBox(height: 15.0,),
          Card(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Assets.share),
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Text(
                            LocaleKeys.key_share,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ).tr()),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 20.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Assets.rate_us),
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child: Text(
                            LocaleKeys.key_rate,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ).tr()),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 20.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(Assets.feedback),
                        height: 40.0,
                        width: 40.0,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                          child:Text(
                            LocaleKeys.key_feedback,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          ).tr()),
                      Icon(
                        Icons.arrow_forward_ios_sharp,
                        size: 20.0,
                        color: Colors.grey,
                      )
                    ],
                  ),
                ),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
               InkWell(onTap: (){
                 Utils.pushReplacement(context, SucessMessage());
               },child:  Container(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     Image(
                       image: AssetImage(Assets.privacy_policy),
                       height: 40.0,
                       width: 40.0,
                     ),
                     SizedBox(
                       width: 10.0,
                     ),
                     Expanded(
                         child: Text(
                           LocaleKeys.key_privacy,
                           style: TextStyle(
                               fontSize: 16,
                               color: Colors.grey,
                               fontWeight: FontWeight.w400),
                         ).tr()),
                     Icon(
                       Icons.arrow_forward_ios_sharp,
                       size: 20.0,
                       color: Colors.grey,
                     )
                   ],
                 ),
               ),)
              ],
            ),
          )
        ],
      ),
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
