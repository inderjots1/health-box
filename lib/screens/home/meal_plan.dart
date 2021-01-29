import 'dart:convert';

import 'package:calendar_flutter/calendar_event.dart';
import 'package:calendar_flutter/calendar_flutter.dart';
import 'package:flutter/material.dart';

import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/all_programs_response_model.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/screens/authentication/login.dart';

import 'package:health_box/screens/order/subscription.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import '../subscrption.dart';
import 'package:http/http.dart' as http;

class MealPlan extends StatefulWidget {
  @override
  _MealPlanState createState() => _MealPlanState();
}

class _MealPlanState extends State<MealPlan> {
  GetAllProgramsResponseModel _getAllProgramsResponseModel =
      new GetAllProgramsResponseModel();
  CustomLoader _customLoader = new CustomLoader();
  LoginResponseModel loginResponseModel;
  String token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromShared();
    _getAllPrograms();
    //  context.bloc<HomeBloc>().add(LoadMovies());
  }

  /*---------------------------------------- get data from Local Storage -------------------------------------*/

  getDataFromShared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(LocalStorage.loginResponseModel) != null) {
      Map userMap = jsonDecode(
          sharedPreferences.getString(LocalStorage.loginResponseModel));
      loginResponseModel = LoginResponseModel.fromJson(userMap);
      token = loginResponseModel.jwt;
    }
  }

  _getAllPrograms() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final response = await http.get(
        endPointAllProgram,
        headers: {"Authorization":"Bearer $token"}
      );

      if (response.body != null) {
        if (response.statusCode == 200) {
          _customLoader.hideLoader();
          if (mounted)
            setState(() {
              var result = json.decode(response.body);
              _getAllProgramsResponseModel =
                  GetAllProgramsResponseModel.fromJson(result);
            });
        } else {
          _customLoader.hideLoader();
          if(response.statusCode==401){
            Utils.toast("your session was expired..");
            _clearAllData();
          }else {
            Utils.toast("${response.statusCode} ");
          }
        }
      } else {
        _customLoader.hideLoader();
        Utils.toast(generalError);
      }
    } else {
      _customLoader.hideLoader();
      Utils.toast(noInternetError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: _header(),
            body: Padding(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   // _calender(),
                    _getAllProgramsResponseModel.programs == null
                        ? Container()
                        : _getAllProgramsResponseModel.programs.isEmpty
                            ? Container()
                            : _listofItems()
                    /*             _vegetarianPlan(LocaleKeys.key_veg_plan, Colors.black54),
                    SizedBox(
                      height: 10.0,
                    ),
                    _vegPlanCard(),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        _vegetarianPlan(
                            LocaleKeys.key_healthy_food_plan, greenColor),
                        _vegetarianPlan("  Your Current Plan", orange),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    _healthyfiidPlan(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _vegetarianPlan(LocaleKeys.key_keto_plan, Colors.black54),
                    SizedBox(
                      height: 10.0,
                    ),
                    ketoCard(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _vegetarianPlan(LocaleKeys.key_loose_plan, Colors.black54),
                    SizedBox(
                      height: 10.0,
                    ),
                    ketoCard()*/
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
            onTap: () {
              _clearAllData();
            },
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  Icons.logout,
                  size: 30.0,
                  color: Colors.black54,
                )),
          )
        ],
      ),
    );
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

  _listofItems() {
    return Container(
      child: ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _getAllProgramsResponseModel.programs.length,
          itemBuilder: (BuildContext context, int index) {
            var item = _getAllProgramsResponseModel.programs[index];
            return InkWell(
              onTap: () {
                Utils.pushReplacement(
                    context,
                    SubscriptionPlan(
                        item.programEnDescribe, item.programArDescribe,item.programId,item.programDiscount,item.programDuration,item.programCost,item.programTitleEn,item.programTitleAr));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    EasyLocalization.of(context).locale.languageCode == "en"
                        ? item.programTitleEn
                        : item.programTitleAr,
                    style: TextStyle(fontSize: 18.0, color: Colors.black54),
                  ).tr(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Utils.cardView(
                      Assets.smile,
                      EasyLocalization.of(context).locale.languageCode == "en"
                          ? item.programTitleEn
                          : item.programTitleAr,
                      EasyLocalization.of(context).locale.languageCode == "en"
                          ? item.programEnDescribe
                          : item.programArDescribe,
                      Colors.white,
                      Colors.black,
                      item.programCost,
                      item.programDuration,
                      item.programTypeEn)
                ],
              ),
            );
          }),
    );
  }

  Widget _vegetarianPlan(String text, Color color) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.0, color: color),
    ).tr();
  }

  Future<void> _clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(LocalStorage.loginResponseModel, null);
    sharedPreferences.setBool(LocalStorage.isLogin, false);
    Utils.pushRemove(context, LoginScreen());
  }
}
