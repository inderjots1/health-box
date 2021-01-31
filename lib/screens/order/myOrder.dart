import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/model/response_model/order_history_response_model.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';

import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import 'orderDetail.dart';
import 'package:http/http.dart' as http;

class MyOrder extends StatefulWidget {
  @override
  _SucessMessageState createState() => _SucessMessageState();
}

class _SucessMessageState extends State<MyOrder> {

  LoginResponseModel user = new LoginResponseModel();
  CustomLoader _customLoader = new CustomLoader();
  OrderHistoryResposneModel _orderHistoryResposneModel = new OrderHistoryResposneModel();
  var token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromShared();
    _getAllPrograms();
  }

  getDataFromShared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(LocalStorage.loginResponseModel) != null) {
      Map userMap = jsonDecode(
          sharedPreferences.getString(LocalStorage.loginResponseModel));
      user = LoginResponseModel.fromJson(userMap);
      token = user.jwt;
    }
  }

  _getAllPrograms() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_id'] = user.user.userId;
      data['user_email'] = user.user.userEmail;
      data['user_password'] = user.user.userPassword;
      data['jwt'] = user.jwt;
      final response = await http.post(
        getUserProgramEndPoint,body: json.encode(data)
      );

      print("purschase ${response.body}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          _customLoader.hideLoader();
          if (mounted)
            setState(() {
              var result = json.decode(response.body);

                _orderHistoryResposneModel =
                    OrderHistoryResposneModel.fromJson(result);
             if(_orderHistoryResposneModel.status=="2"){
                Utils.toast("No Programs for User");
              }else if(_orderHistoryResposneModel.status=="3"){
                Utils.toast("No Programs for User");
              }

            });
        } else {
          _customLoader.hideLoader();
          Utils.toast("${response.statusCode} ");
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
          backgroundColor: Colors.white,
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
            Align(alignment: Alignment.topRight,child: InkWell(onTap: (){
              Navigator.pop(context);
            },child: Icon(Icons.clear),),),
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
             _orderHistoryResposneModel==null?Container():_orderHistoryResposneModel.programs==null?Container():_orderHistoryResposneModel.programs.isEmpty?Container(child:Center(child:Text("You don't have purchase any plan"))): Container(child: ListView.builder(
               itemCount: _orderHistoryResposneModel.programs.length,
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
               itemBuilder: (context, i) {
                 var item = _orderHistoryResposneModel.programs[i];
                 return InkWell(onTap: (){
                   Utils.pushReplacement(context, OrderDetail());
                 },child: Container(child:Column(children: [
                   Divider(),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text("Plan #${item.participationId}",style: TextStyle(color: Colors.black,fontSize: 16.0,fontWeight: FontWeight.w500),),
                       Text("KD 128.00",style: TextStyle(color: Colors.green),)
                     ],),
                   SizedBox(height: 10.0,),
                   Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(item.statusEn==null?"Pending":item.statusEn,style: TextStyle(color: Colors.greenAccent),),
                       Text("${item.programStartDate}",style: TextStyle(color: Colors.black),)
                     ],),


                 ],),),);
               },
             ),)
           ],),),
        /*    Align(
              alignment: Alignment.bottomCenter,
              child: RoundedButtonWidget(
                buttonColor: greenColor,
                buttonText: LocaleKeys.key_need_help,
                textColor: Colors.white,
                onPressed: () {

                },
                isIconDisplay: false,
              )
            )*/
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
