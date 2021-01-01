import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';

class Subscrition extends StatefulWidget {
  @override
  _SubscritionState createState() => _SubscritionState();
}

class _SubscritionState extends State<Subscrition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [
      Container(height: 200.0,width: MediaQuery.of(context).size.width
        ,child: Image(image: AssetImage(Assets.artwork),
        width:MediaQuery.of(context).size.width ,),)
    ],),);
  }
}
