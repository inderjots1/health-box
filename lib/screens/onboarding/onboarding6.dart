import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/constants/strings.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/model/response_model/register_response_mode.dart';
import 'package:health_box/screens/home/homeScreen.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant.dart';
import 'package:http/http.dart' as http;


class OnBoarding6 extends StatefulWidget {
  String name, email, password, gender, motivation, age,tall,weight;

  OnBoarding6(this. name, this. email, this. password, this. gender, this. motivation, this. age, this. tall, this. weight);

  @override
  _OnBoarding1State createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding6> {
  int _currentSelection = 0;
  Map<int, Widget> _children = {
    0: Text(LocaleKeys.key_lb).tr(),
    1: Text(LocaleKeys.key_kg).tr(),
  };
  CustomLoader _customLoader = new CustomLoader();
  var text = "Kg";
  var goalWeight="";
  TextEditingController textEditingController = new TextEditingController();
  RegisterResponseModel registerResponseModel = new RegisterResponseModel();
  LoginResponseModel _loginResponseModel =new LoginResponseModel();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();
  var token;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firbaseMessage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(Assets.slide6),
                          height: 5.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Image(
                          image: AssetImage(Assets.appLogo),
                          height: 60.0,
                          width: 100.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          LocaleKeys.key_your_goal,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ).tr()
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(),
                        flex: 1,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Container(
                                        width: 100,
                                        child: RoundedButtonWidget(
                                          buttonColor: greenColor,
                                          buttonText: LocaleKeys.key_skip,
                                          width: 100,
                                          textColor: Colors.white,
                                          onPressed: () {
                                            _userRegister(widget.name,widget.email,widget.password,widget.gender,widget.motivation,widget.age,widget.tall,widget.weight,this.goalWeight);

                                          },
                                          isIconDisplay: false,
                                        ),
                                      )),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(width: 100.0,child: TextFormField(
                                       controller: textEditingController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(5),
                                        ],
                                        style: TextStyle(fontSize: 30),
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.length < 3) {
                                            return 'a minimum of 3 characters is required';
                                          }
                                        },
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          suffixText: text,
                                          suffixStyle: TextStyle(fontSize: 16),
                                        )),),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                          /*  MaterialSegmentedControl(
                              children: _children,
                              selectionIndex: _currentSelection,
                              borderColor: Colors.grey,
                              selectedColor: greenColor,
                              unselectedColor: Colors.white,
                              borderRadius: 20.0,
                              *//*  disabledChildren: [
                            1
                          ],*//*
                              onSegmentChosen: (index) {
                                setState(() {
                                  _currentSelection = index;
                                  if(index==0){
                                    text ="Lb";
                                  }else if(index ==1){
                                    text =" Kg";
                                  }
                                });
                              },
                            )*/
                          ],
                        ),
                        flex: 2,
                      ),

                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: RoundedButtonWidget(
                        buttonColor: greenColor,
                        buttonText: LocaleKeys.key_next,
                        textColor: Colors.white,
                        onPressed: () {
                          goalWeight = textEditingController.text;
                          if(goalWeight.isEmpty){
                           Utils.toast("please enter our goal Weight");
                          }else{
                            _userRegister(widget.name,widget.email,widget.password,widget.gender,widget.motivation,widget.age,widget.tall,widget.weight,this.goalWeight);
                          }
                        },
                        isIconDisplay: false,
                      )),
                )
              ],
            ),
          ),
        ));
  }

  _userRegister(String name,String email,String password,String gender,String motivation,String age,String tall, String weight,String goal) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);

      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_name'] = name;
      data['user_email'] = email;
      data['user_password'] = password;
      data['user_telep'] = " ";
      data['user_another_telep'] = " ";
      data['user_gender'] = gender;
      data['user_age'] = age;
      data['user_tall'] = tall;
      data['user_weight'] = weight;
      data['user_motivation'] = motivation;
      data['user_goal_weight'] = goal;
      data['user_firebase'] = token;

      print("data ${json.encode(data)}");

      final response = await http.post(registerUser,
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          registerResponseModel = RegisterResponseModel.fromJson(result);
          if (registerResponseModel.status == "1") {
            _customLoader.hideLoader();
            _userLogin(email, password);
          } else {
            Utils.toast(registerResponseModel.message);
            _customLoader.hideLoader();
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            registerResponseModel = RegisterResponseModel.fromJson(result);
            Utils.toast(registerResponseModel.message);
            _customLoader.hideLoader();
          } else {
            Utils.toast("${response.statusCode}");
            _customLoader.hideLoader();
          }
        }
      } else {
        Utils.toast(generalError);
        _customLoader.hideLoader();
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  _userLogin(String email, String password) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_email'] = email;
      data['user_password'] = password;

      final response = await http.post(loginUser,
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      print("logib ${response.body}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          _loginResponseModel = LoginResponseModel.fromJson(result);
          if (_loginResponseModel.status == "1") {
            Utils.pushRemove(context, HomeScreen());
            Utils.toast(_loginResponseModel.message);
          //  loginDataStoreTOLocalStorage(result);
          } else {
            Utils.toast(_loginResponseModel.message);
          }
        } else {
          Utils.toast("${response.statusCode} ");
        }
      } else {
        Utils.toast(generalError);
        _customLoader.hideLoader();
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  /*--------------------------------------------- login data store in local storage ------------------------------------------------*/
  void loginDataStoreTOLocalStorage(result) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user = jsonEncode(LoginResponseModel.fromJson(result));
    sharedPreferences.setString(LocalStorage.loginResponseModel, user);
    sharedPreferences.setBool(LocalStorage.isLogin, true);

    getDataFromShared();
  }


  /*--------------------------------------------- get data from Local Storage -------------------------------------------------------*/

  void getDataFromShared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(
        sharedPreferences.getString(LocalStorage.loginResponseModel));
    var user = LoginResponseModel.fromJson(userMap);
  }

  void firbaseMessage() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android:android,iOS:  ios);
    flutterLocalNotificationsPlugin.initialize(platform);

    firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> msg) {
        print(" onLaunch called ${(msg)}");
      },
      onResume: (Map<String, dynamic> msg) {
        print(" onResume called ${(msg)}");
      },
      onMessage: (Map<String, dynamic> msg) {
        showNotification(msg);
        print(" onMessage called ${(msg)}");
      },
    );
    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings setting) {
      print('IOS Setting Registed');
    });
    firebaseMessaging.getToken().then((mytoken) {
      update(mytoken);
    });
  }

  update(String mytoken) {
    print(mytoken);
    token = mytoken;

    if (this.token == null) {
    } else {
      //_tokenUpdate(mytoken);
    }
  }

  showNotification(Map<String, dynamic> msg) async {
    var mesaj = Person(
      name: Platform.isIOS ? msg["title"] : msg["data"]["title"],
      key: '1',
    );
    //iconSource: IconSource.FilePath);
    var mesajStyle = MessagingStyleInformation(mesaj, messages: [
      Message(Platform.isIOS ? msg["body"] : msg["data"]["body"],
          DateTime.now(), mesaj)
    ]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '1234',
      'Yeni Mesaj',
      'your channel description',
      /*   styleInformation: mesajStyle,*/
     importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android:
        androidPlatformChannelSpecifics, iOS:iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        Platform.isIOS ? msg["title"] : msg["data"]["title"],
        Platform.isIOS ? msg["body"] : msg["data"]["body"],
        platformChannelSpecifics,
        payload: jsonEncode(msg));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customLoader.hideLoader();
  }
}
