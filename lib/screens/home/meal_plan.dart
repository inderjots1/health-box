import 'package:calendar_flutter/calendar_event.dart';
import 'package:calendar_flutter/calendar_flutter.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';

import 'package:health_box/screens/order/subscription.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:easy_localization/easy_localization.dart';

import '../subscrption.dart';

class MealPlan extends StatefulWidget {
  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: _header(),
            body: Padding(
      padding: EdgeInsets.all(10.0),
      child:  SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _calender(),
            _vegetarianPlan(LocaleKeys.key_veg_plan,Colors.black54),
            SizedBox(
              height: 10.0,
            ),
            _vegPlanCard(),
            SizedBox(
              height: 10.0,
            ),
            Row(children: [
              _vegetarianPlan(LocaleKeys.key_healthy_food_plan,greenColor),
              _vegetarianPlan("  Your Current Plan",orange),
            ],),
            SizedBox(
              height: 10.0,
            ),
            _healthyfiidPlan(),
            SizedBox(height: 10.0,),
            _vegetarianPlan(LocaleKeys.key_keto_plan,Colors.black54),
            SizedBox(
              height: 10.0,
            ),
            ketoCard(),
            SizedBox(height: 10.0,),
            _vegetarianPlan(LocaleKeys.key_loose_plan,Colors.black54),
            SizedBox(
              height: 10.0,
            ),
            ketoCard()
          ],
        ),
      ),
    )));
  }

  Widget _header() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
         LocaleKeys.key_pick_meal_plan,
          style: TextStyle(color: Colors.black, fontSize: 25.0),
        ).tr(),
        InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: Image(
              image: AssetImage(Assets.settings),
              width: 30.0,
              height: 30.0,
            ),
          ),
        )
      ],
    ),);
  }

  _calender() {
    return Container(
      height: 100.0,
    );
  }

  void setCalendarEvents() {
    List<CalendarEvent> eventsList = List<CalendarEvent>();

    CalendarEvent event = CalendarEvent();
    event.title = "Meeting";
    event.startTime = DateTime(2019, 07, 01);
    event.endTime = DateTime(2019, 07, 10);
    eventsList.add(event);

    event = CalendarEvent();
    event.title = "Meeting2";
    event.startTime = DateTime(2019, 07, 06);
    event.endTime = DateTime(2019, 07, 15);
    eventsList.add(event);
    CalendarEvent.setListAndUpdateMap(eventsList);
  }

  Widget _vegetarianPlan(String text,Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.0, color: color),
    ).tr();
  }

  _vegPlanCard() {
    return InkWell(onTap: (){
      Utils.pushReplacement(context, SubscriptionPlan());
    },child: Utils.cardView(Assets.veg_plan, LocaleKeys.key_vegh1,
        LocaleKeys.key_vegh2, Colors.white, Colors.black, "102Kd"),);
  }

  _healthyfiidPlan() {
    return Utils.cardView(Assets.smile, LocaleKeys.key_health1,
        LocaleKeys.key_health2, greenColor, Colors.white, "105Kd");
  }
  ketoCard() {
    return Utils.cardView(Assets.veg_plan, LocaleKeys.key_keto1,
        LocaleKeys.key_keto2, Colors.white, Colors.black, "145Kd");
  }
  lossWeight() {
    return Utils.cardView(Assets.veg_plan, LocaleKeys.key_loose_plan1,
        LocaleKeys.key_loose_plan2, Colors.white, Colors.black, "145Kd");
  }
}
