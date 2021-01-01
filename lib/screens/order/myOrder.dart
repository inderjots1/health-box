import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/generated/locale_keys.g.dart';

import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';

import 'orderDetail.dart';

class MyOrder extends StatefulWidget {
  @override
  _SucessMessageState createState() => _SucessMessageState();
}

class _SucessMessageState extends State<MyOrder> {
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
            Align(alignment: Alignment.topRight,child: InkWell(onTap: (){},child: Icon(Icons.clear),),),
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
           Container(color: Colors.white,margin: EdgeInsets.only(bottom: 50.0,top: 100.0,left: 15.0,right: 15.0),
           child: Column(children: [
             Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
               Text(LocaleKeys.key_my_order,style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),).tr(),
                 Image(
                   image: AssetImage(Assets.yoga),
                   height: 60.0,
                   width: 60.0,
                 ),
             ],),
             Container(child: ListView.builder(
               itemCount: 6,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (context, i) {
                 return InkWell(onTap: (){
                   Utils.pushReplacement(context, OrderDetail());
                 },child: Container(child:Column(children: [
                   Divider(),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Plan #456123",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.w500),),
                       Text("KD 128.00",style: TextStyle(color: Colors.green),)
                     ],),
                   SizedBox(height: 10.0,),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Finished",style: TextStyle(color: Colors.greenAccent),),
                       Text("july 24,2020",style: TextStyle(color: Colors.black),)
                     ],),


                 ],),),);
               },
             ),)
           ],),),
            Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButtonWidget(
                buttonColor: greenColor,
                buttonText: LocaleKeys.key_need_help,
                textColor: Colors.white,
                onPressed: () {

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
