import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/connect.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/screens/home/meal_plan.dart';
import 'package:health_box/screens/home/profile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;
  var _previousIndex = 0;

  var  _myTabs = [
    MealPlan(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // checkInternet().checkConnection(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // checkInternet().listener.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: _myTabs[_currentIndex],
      bottomNavigationBar: _bottomBar(),
    ));
  }

  Widget _bottomBar() {
    return  Container(
      height: 80.0,
        margin: EdgeInsets.only(left: 30.0,right: 30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            elevation: 0.0,
            currentIndex: _currentIndex,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            unselectedFontSize: 14.0,
            selectedFontSize: 14.0,
            selectedItemColor: greenColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon:Padding(padding: EdgeInsets.all(10.0),child:  ImageIcon(AssetImage(Assets.note)),), label: "Meal Plan",),
              BottomNavigationBarItem(
                  icon: Padding(padding: EdgeInsets.all(10.0),child:   ImageIcon(AssetImage(Assets.profile)),), label: "Profile",)
            ],
            onTap: (int index) {
              setState(() {
                _previousIndex = _currentIndex;
                _currentIndex = index;
              });
            },
          ),
        )
    );
  }
}
