import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../custtom.dart';

class OrderDetail extends StatefulWidget {
  @override
  _SucessMessageState createState() => _SucessMessageState();
}

class _SucessMessageState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white,
              child: ListView(
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

           Container(color: Colors.white,margin: EdgeInsets.only(bottom: 50.0,top: 100.0,),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
             Text("${LocaleKeys.key_order.tr()} #562356",style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),).tr(),
             SizedBox(height: 5.0,),
             Text(LocaleKeys.key_current,style: TextStyle(color: greenColor,fontSize: 14.0),).tr(),
               SizedBox(height: 10.0,),
               _vegPlanCard(),
              Center(child:  Text(LocaleKeys.key_select_date,style: TextStyle(color: greenColor,fontWeight: FontWeight.w500,fontSize: 18.0),).tr(),),
               SizedBox(height: 10.0,),
               CustomCalendar(),
               SizedBox(height: 15.0,),
               _myorder(),
               SizedBox(height: 10.0,),
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                 Container(height: 15.0,width: 30.0,color: Colors.grey,),
                 SizedBox(width: 10.0,),
                 Text(LocaleKeys.key_unaable,style: TextStyle(color: greenColor,fontWeight: FontWeight.bold),).tr()
               ],)
           ],),),

          ],
        ));
  }

  _vegPlanCard() {
    return InkWell(onTap: (){

    },child: Utils.cardView(Assets.veg_plan, "Vegetatian",
        "I can't eat meat and seafood", Colors.white, Colors.black, "102Kd","d0","d"),);
  }
  
  Widget _myorder(){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
     Row(children: [
       Container(height: 15.0,width: 30.0,color: greenColor,),
       SizedBox(width: 10.0,),
       Text(LocaleKeys.key_start_date,style: TextStyle(color: greenColor,fontWeight: FontWeight.bold),).tr()
     ],),
        Row(children: [
          Container(height: 15.0,width: 30.0,color: Colors.grey[200],),
          SizedBox(width: 10.0,),
          Text(LocaleKeys.key_not_selected,style: TextStyle(color: greenColor,fontWeight: FontWeight.bold),).tr()
        ],)
    ],);

  }
}
