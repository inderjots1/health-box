import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/auth_token.dart';
import 'package:health_box/model/response_model/change_password_data_model.dart';
import 'package:health_box/model/response_model/clear_token.dart';
import 'package:health_box/model/response_model/get_current_profile_response_model.dart';
import 'package:health_box/model/response_model/image_upload.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/model/response_model/update_user_response_model.dart';
import 'package:health_box/screens/authentication/login.dart';
import 'package:health_box/screens/order/Feedback.dart';

import 'package:health_box/screens/order/myOrder.dart';
import 'package:health_box/screens/order/privacy.dart';
import 'package:health_box/screens/order/sucessMessage.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:health_box/utitlity/Validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  bool isSwitched1 = false;
  var notificationToken;

  LoginResponseModel user;
  ClearTokenResponseModel clearTokenResponseModel =
      new ClearTokenResponseModel();
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  UpdateUserResponseModel updateUserResponseModel =
      new UpdateUserResponseModel();
  GetProfileResponseModel _getProfileResponseModel =
      new GetProfileResponseModel();
  ImageUploadResponseModel _imageUploadResponseModel =
      new ImageUploadResponseModel();
  AuthTokenGenerationResposeModel _authTokenGenerationResposeModel = new AuthTokenGenerationResposeModel();
  LoginResponseModel _loginResponseModel = new LoginResponseModel();
  var token;
  File imageFile;
  CustomLoader _customLoader = new CustomLoader();
  TextEditingController _strPassword = new TextEditingController();
  TextEditingController _strConfirmPassword = new TextEditingController();
  TextStyle textStyle =
      TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Roboto');
  final FocusNode _passwor = new FocusNode();
  final FocusNode _confirmPass = new FocusNode();
  bool passwordVisible = true;
  bool cpasswordVisible = true;

  ChangePasswordResponseModel _changePasswordResponseModel =
      new ChangePasswordResponseModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isChanged();

  }

  isChanged() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print("sanjadsn ${sharedPreferences.getBool("language")}");
    Map userMap = jsonDecode(
        sharedPreferences.getString(LocalStorage.loginResponseModel));
    user = LoginResponseModel.fromJson(userMap);
    notificationToken = user.user.userFirebase;
    firbaseMessage();
    getCurrentProfile();
    if (sharedPreferences.getBool("language") != null) {
      isSwitched = sharedPreferences.getBool("language");
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteLIGHT,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            _profileHeader(),
            _about(),
            _supportUs()
          ],
        ),
      ),
    );
  }

  Widget _profileHeader() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.0),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _clearAllData();
            },
            child: Align(alignment: Alignment.topRight,
              child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.logout,size: 30.0,color: Colors.black54,)
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _showSelectionDialog(context);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image(
                image: _getProfileResponseModel == null
                    ? AssetImage(Assets.avtar)
                    : _getProfileResponseModel.user == null
                        ? AssetImage(Assets.avtar)
                        : _getProfileResponseModel.user.userImagePath == ""
                            ? AssetImage(Assets.avtar)
                            : NetworkImage(imageRenderUrl +
                                _getProfileResponseModel.user.userImagePath),
                height: 80.0,
                width: 80.0,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            _getProfileResponseModel == null
                ? "HealthyBox"
                : _getProfileResponseModel.user == null
                    ? "HealthyBox"
                    : _getProfileResponseModel.user.userName,
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
                _getProfileResponseModel == null
                    ? "healthbox@gmail.com"
                    : _getProfileResponseModel.user == null
                        ? "healthbox@gmail.com"
                        : _getProfileResponseModel.user.userEmail,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 10.0,
              ),
              /*InkWell(
                onTap: () {
                 // emailUpdateDialog(context);
                },
                child: Image(
                  image: AssetImage(Assets.edit_icon),
                  height: 20.0,
                  width: 20.0,
                ),
              )*/
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
                      _getProfileResponseModel == null
                          ? "XXXXXXXX"
                          : _getProfileResponseModel.user == null
                              ? "XXXXXXXX"
                              : _getProfileResponseModel.user.userTelep
                                          .trim() ==
                                      ""
                                  ? "XXXXXXX"
                                  : _getProfileResponseModel.user.userTelep,
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        phoneUpdateDialog(context);
                      },
                      child: Image(
                        image: AssetImage(Assets.edit_icon),
                        height: 15.0,
                        width: 15.0,
                      ),
                    )
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
                      _getProfileResponseModel == null
                          ? "XX"
                          : _getProfileResponseModel.user == null
                              ? "XX"
                              : _getProfileResponseModel.user.userWeight + "kg",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        weightUpdateDialog(context);
                      },
                      child: Image(
                        image: AssetImage(Assets.edit_icon),
                        height: 15.0,
                        width: 15.0,
                      ),
                    )
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
                      _getProfileResponseModel == null
                          ? "XX"
                          : _getProfileResponseModel.user == null
                              ? "XX"
                              : _getProfileResponseModel.user.userTall + " Cm",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    InkWell(
                      onTap: () {
                        tallUpdateDialog(context);
                      },
                      child: Image(
                        image: AssetImage(Assets.edit_icon),
                        height: 15.0,
                        width: 15.0,
                      ),
                    )
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
          SizedBox(
            height: 15.0,
          ),
          Card(
            child: Column(
              children: [
                /*Container(
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
                ),*/
                InkWell(
                  onTap: () {
                    Utils.pushReplacement(context, MyOrder());
                  },
                  child: Container(
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
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
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
                            if (isSwitched1 == true) {
                              _notificationOn();
                            } else {
                              _disableNotification(
                                  _getProfileResponseModel.user.userEmail,
                                  _getProfileResponseModel.user.userPassword);
                            }
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
               InkWell(onTap: (){
                 showDialogs(context);
               },child:  Container(
                 padding: EdgeInsets.all(8.0),
                 child: Row(
                   children: [
                     Icon(
                       Icons.lock_open,
                       size: 40.0,
                       color: greenColor,
                     ),
                     SizedBox(
                       width: 10.0,
                     ),
                     Expanded(
                         child: Text(
                           LocaleKeys.key_change_password,
                           style: TextStyle(
                               fontSize: 16,
                               color: Colors.grey,
                               fontWeight: FontWeight.w400),
                         ).tr()),
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
          SizedBox(
            height: 15.0,
          ),
          Card(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Share.share('check out my website https://example.com',
                        subject: 'Look what I made!');
                  },
                  child: Container(
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
                ),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                InkWell(onTap:(){
                  Utils.toast("comming soon...");
                },child: Container(
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
               ),),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
               InkWell(onTap: (){
Utils.pushReplacement(context, Feedbacks());
               },child:  Container(
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
                         child: Text(
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
               ),),
                Divider(
                  indent: 15.0,
                  endIndent: 15.0,
                ),
                InkWell(
                  onTap: () {
                   Utils.pushReplacement(context, PrivacyPolicy());
                  },
                  child: Container(
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
                  ),
                )
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

  _disableNotification(String email, String password) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_email'] = email;
      data['user_password'] = password;

      final response = await http.post(clearToken,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("logib ${response.body}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          clearTokenResponseModel = ClearTokenResponseModel.fromJson(result);
          if (clearTokenResponseModel.status == "1") {
            notificationToken == null;
            Utils.toast("your Notification is Disable");
          } else {
            Utils.toast(clearTokenResponseModel.message);
          }
        } else {
          Utils.toast("${response.statusCode} ");
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  _notificationOn() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_name'] = _getProfileResponseModel.user.userName;
      data['user_email'] = _getProfileResponseModel.user.userEmail;
      data['user_password'] = _getProfileResponseModel.user.userPassword;
      data['user_telep'] = _getProfileResponseModel.user.userTelep;
      data['user_another_telep'] =
          _getProfileResponseModel.user.userAnotherTelep;
      if (user.user.userGender == "Male") {
        data['user_gender'] = "1";
      } else {
        data['user_gender'] = "2";
      }
      data['user_age'] = _getProfileResponseModel.user.userAge;
      data['user_tall'] = _getProfileResponseModel.user.userTall;
      data['user_weight'] = _getProfileResponseModel.user.userWeight;
      data['user_motivation'] = _getProfileResponseModel.user.userMotivation;
      data['user_goal_weight'] = _getProfileResponseModel.user.userGoalWeight;
      data['user_firebase'] = token;
      data['jwt'] = user.jwt;
      print("data ${json.encode(data)}");
      final response = await http.post(updateUser,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
          if (updateUserResponseModel.status == "1") {
            Utils.toast("your Notification is Enabled");
          } else {
            Utils.toast(updateUserResponseModel.message);
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
            Utils.toast(updateUserResponseModel.message);
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  void firbaseMessage() {
    var android = new AndroidInitializationSettings('mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var platform = new InitializationSettings(android: android, iOS: ios);
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
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        Platform.isIOS ? msg["title"] : msg["data"]["title"],
        Platform.isIOS ? msg["body"] : msg["data"]["body"],
        platformChannelSpecifics,
        payload: jsonEncode(msg));
  }

  /*-------------------------------------------- get image from camera and gallery ----------------------------------------*/

  Future _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(LocaleKeys.key_take_photo_messsage).tr(),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  /*------------------------------------------------ Pick Image From Gallery --------------------------------------------*/

  void _openGallery(BuildContext context) async {
    //var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    var picture =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    File file = File(picture.path);
    if (mounted)
      setState(() {
        imageFile = file;
      });
    Navigator.of(context).pop();
    imageUpload();
  }

  /*------------------------------------------------ pickImage Using Camera ---------------------------------------------*/
  void _openCamera(BuildContext context) async {
    var picture = await ImagePicker().getImage(source: ImageSource.camera);
    File file = File(picture.path);
    if (mounted)
      setState(() {
        imageFile = file;
      });
    Navigator.of(context).pop();
    imageUpload();
  }

  imageUpload() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {

      await getSecurityLevelToken();
      var tokens = _authTokenGenerationResposeModel.jwt;
      var request = http.MultipartRequest("POST", Uri.parse(uploadImage));
      request.headers["Authorization"] = "Bearer ${tokens}";
      var pic =
          await http.MultipartFile.fromPath("file_upload", imageFile.path);
      print('file${tokens}');

      request.files.add(pic);
      print('paths ${request.files.length}');
      print('headers ${request.headers}');
      print('fields ${request.fields}');
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var result = json.decode(responseString);

      print(" edti ${result}");

      if (response.statusCode == 200) {
        _imageUploadResponseModel = ImageUploadResponseModel.fromJson(result);
        updateImageApiCall(_imageUploadResponseModel.imagePath);
      } else {
        Utils.toast(" ${response.statusCode} ${generalError}");
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  emailUpdateDialog(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController textEditingController = new TextEditingController();
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    child: Icon(Icons.cancel),
                                  )
                                ],
                              )),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.text,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      controller: textEditingController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Oops! please enter email -id';
                                        }
                                      },
                                      decoration: new InputDecoration(
                                        labelText: "Email",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: "Email",
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, left: 40.0, right: 40.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  minWidth: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () => {
                                    if (_formKey.currentState.validate())
                                      {
                                        Utils.hideKeyboard(context),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog'),
                                        emailUpdateApi(
                                            textEditingController.text)
                                      }
                                  },
                                  color: greenColor,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  phoneUpdateDialog(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController ptextEditingController = new TextEditingController();
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Mobile Number",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    child: Icon(Icons.cancel),
                                  )
                                ],
                              )),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 8,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      controller: ptextEditingController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Oops! please enter mobile no';
                                        }
                                      },
                                      decoration: new InputDecoration(
                                        labelText: "Mobile Number",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: "Mobile Number",
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, left: 40.0, right: 40.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  minWidth: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () => {
                                    if (_formKey.currentState.validate())
                                      {
                                        Utils.hideKeyboard(context),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog'),
                                        updatePhoneNumber(
                                            ptextEditingController.text)
                                      }
                                  },
                                  color: greenColor,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  weightUpdateDialog(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController wtextEditingController = new TextEditingController();
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Weight",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    child: Icon(Icons.cancel),
                                  )
                                ],
                              )),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      controller: wtextEditingController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Oops! please enter weight';
                                        }
                                      },
                                      decoration: new InputDecoration(
                                        labelText: "Weight",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: "Weight",
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, left: 40.0, right: 40.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  minWidth: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () => {
                                    if (_formKey.currentState.validate())
                                      {
                                        Utils.hideKeyboard(context),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog'),
                                        updateWeight(
                                            wtextEditingController.text)
                                      }
                                  },
                                  color: greenColor,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  tallUpdateDialog(BuildContext context) {
    var _formKey = GlobalKey<FormState>();
    TextEditingController talltextEditingController =
        new TextEditingController();
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 300),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Edit Tall",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 18.0),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                    child: Icon(Icons.cancel),
                                  )
                                ],
                              )),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                      maxLines: 1,
                                      controller: talltextEditingController,
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'Oops! please enter tall';
                                        }
                                      },
                                      decoration: new InputDecoration(
                                        labelText: "Tall",
                                        labelStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w400),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        hintText: "Tall",
                                        contentPadding: EdgeInsets.only(
                                            left: 15,
                                            bottom: 11,
                                            top: 11,
                                            right: 15),
                                      ),
                                    ))
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0, left: 40.0, right: 40.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  minWidth: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  onPressed: () => {
                                    if (_formKey.currentState.validate())
                                      {
                                        Utils.hideKeyboard(context),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog'),
                                        tallUpdate(
                                            talltextEditingController.text)
                                      }
                                  },
                                  color: greenColor,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Text(
                                        "Update",
                                        style: TextStyle(color: Colors.white),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  Future<void> updateImageApiCall(String imagePath) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_image_path'] = imagePath;
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_name'] = _getProfileResponseModel.user.userName;
      data['user_email'] = _getProfileResponseModel.user.userEmail;
      data['user_password'] = _getProfileResponseModel.user.userPassword;
      data['user_telep'] = _getProfileResponseModel.user.userTelep;
      data['user_another_telep'] =
          _getProfileResponseModel.user.userAnotherTelep;
      if (user.user.userGender == "Male") {
        data['user_gender'] = "1";
      } else {
        data['user_gender'] = "2";
      }
      data['user_age'] = _getProfileResponseModel.user.userAge;
      data['user_tall'] = _getProfileResponseModel.user.userTall;
      data['user_weight'] = _getProfileResponseModel.user.userWeight;
      data['user_motivation'] = _getProfileResponseModel.user.userMotivation;
      data['user_goal_weight'] = _getProfileResponseModel.user.userGoalWeight;
      data['user_firebase'] = _getProfileResponseModel.user.userFirebase;
      data['jwt'] = user.jwt;
      print("data ${json.encode(data)}");
      final response = await http.post(updateUser,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
          if (updateUserResponseModel.status == "1") {
            getCurrentProfile();
            _customLoader.hideLoader();
          } else {
            Utils.toast(updateUserResponseModel.message);
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
            Utils.toast(updateUserResponseModel.message);
            _customLoader.hideLoader();
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  getCurrentProfile() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_email'] = user.user.userEmail;
      data['user_password'] = user.user.userPassword;

      final response = await http.post(getCurrentUser,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer ${user.jwt}"
          },
          body: json.encode(data));
      print("reg ${response.body}");
      print("email  ${user.user.userEmail} password ${user.user.userPassword}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          _customLoader.hideLoader();
          var result = json.decode(response.body);
          _getProfileResponseModel = GetProfileResponseModel.fromJson(result);
          if (_getProfileResponseModel.status == "1") {
            if (mounted) setState(() {});
            if (_getProfileResponseModel.user.userFirebase == null ||
                _getProfileResponseModel.user.userFirebase.trim().isEmpty) {
              setState(() {
                isSwitched1 = false;
              });
            } else {
              setState(() {
                isSwitched1 = true;
              });
            }
          } else if(_getProfileResponseModel.status == "0") {
            Utils.toast("your session was expired..");
            _clearAllData();
            Utils.toast(_getProfileResponseModel.message);
          }
        } else {
          _customLoader.hideLoader();
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            _getProfileResponseModel = GetProfileResponseModel.fromJson(result);
            Utils.toast(_getProfileResponseModel.message);
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        _customLoader.hideLoader();
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  updatePhoneNumber(String text) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_image_path'] = _getProfileResponseModel.user.userImagePath;
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_name'] = _getProfileResponseModel.user.userName;
      data['user_email'] = _getProfileResponseModel.user.userEmail;
      data['user_password'] = _getProfileResponseModel.user.userPassword;
      data['user_telep'] = text;
      data['user_another_telep'] = text;
      if (user.user.userGender == "Male") {
        data['user_gender'] = "1";
      } else {
        data['user_gender'] = "2";
      }
      data['user_age'] = _getProfileResponseModel.user.userAge;
      data['user_tall'] = _getProfileResponseModel.user.userTall;
      data['user_weight'] = _getProfileResponseModel.user.userWeight;
      data['user_motivation'] = _getProfileResponseModel.user.userMotivation;
      data['user_goal_weight'] = _getProfileResponseModel.user.userGoalWeight;
      data['user_firebase'] = _getProfileResponseModel.user.userFirebase;
      data['jwt'] = user.jwt;
      print("data ${json.encode(data)}");
      final response = await http.post(updateUser,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
          if (updateUserResponseModel.status == "1") {
            getCurrentProfile();
            _customLoader.hideLoader();
          } else {
            Utils.toast(updateUserResponseModel.message);
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
            Utils.toast(updateUserResponseModel.message);
            _customLoader.hideLoader();
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  updateWeight(String text) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_image_path'] = _getProfileResponseModel.user.userImagePath;
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_name'] = _getProfileResponseModel.user.userName;
      data['user_email'] = _getProfileResponseModel.user.userEmail;
      data['user_password'] = _getProfileResponseModel.user.userPassword;
      data['user_telep'] = _getProfileResponseModel.user.userTelep;
      data['user_another_telep'] =
          _getProfileResponseModel.user.userAnotherTelep;
      if (_getProfileResponseModel.user.userGender == "Male") {
        data['user_gender'] = "1";
      } else {
        data['user_gender'] = "2";
      }
      data['user_age'] = _getProfileResponseModel.user.userAge;
      data['user_tall'] = _getProfileResponseModel.user.userTall;
      data['user_weight'] = text;
      data['user_motivation'] = _getProfileResponseModel.user.userMotivation;
      data['user_goal_weight'] = _getProfileResponseModel.user.userGoalWeight;
      data['user_firebase'] = _getProfileResponseModel.user.userFirebase;
      data['jwt'] = _getProfileResponseModel.user.jwt;
      print("data ${json.encode(data)}");
      final response = await http.post(updateUser,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
          if (updateUserResponseModel.status == "1") {
            getCurrentProfile();
            _customLoader.hideLoader();
          } else {
            Utils.toast(updateUserResponseModel.message);
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
            Utils.toast(updateUserResponseModel.message);
            _customLoader.hideLoader();
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  tallUpdate(String text) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_image_path'] = _getProfileResponseModel.user.userImagePath;
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_name'] = _getProfileResponseModel.user.userName;
      data['user_email'] = _getProfileResponseModel.user.userEmail;
      data['user_password'] = _getProfileResponseModel.user.userPassword;
      data['user_telep'] = _getProfileResponseModel.user.userTelep;
      data['user_another_telep'] =
          _getProfileResponseModel.user.userAnotherTelep;
      if (_getProfileResponseModel.user.userGender == "Male") {
        data['user_gender'] = "1";
      } else {
        data['user_gender'] = "2";
      }
      data['user_age'] = _getProfileResponseModel.user.userAge;
      data['user_tall'] = text;
      data['user_weight'] = _getProfileResponseModel.user.userWeight;
      data['user_motivation'] = _getProfileResponseModel.user.userMotivation;
      data['user_goal_weight'] = _getProfileResponseModel.user.userGoalWeight;
      data['user_firebase'] = _getProfileResponseModel.user.userFirebase;
      data['jwt'] = _getProfileResponseModel.user.jwt;
      print("data ${json.encode(data)}");
      final response = await http.post(updateUser,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
          if (updateUserResponseModel.status == "1") {
            getCurrentProfile();
            _customLoader.hideLoader();
          } else {
            Utils.toast(updateUserResponseModel.message);
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
            Utils.toast(updateUserResponseModel.message);
            _customLoader.hideLoader();
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  emailUpdateApi(String text) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_image_path'] = _getProfileResponseModel.user.userImagePath;
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_name'] = _getProfileResponseModel.user.userName;
      data['user_email'] = text;
      data['user_password'] = _getProfileResponseModel.user.userPassword;
      data['user_telep'] = _getProfileResponseModel.user.userTelep;
      data['user_another_telep'] =
          _getProfileResponseModel.user.userAnotherTelep;
      if (_getProfileResponseModel.user.userGender == "Male") {
        data['user_gender'] = "1";
      } else {
        data['user_gender'] = "2";
      }
      data['user_age'] = _getProfileResponseModel.user.userAge;
      data['user_tall'] = _getProfileResponseModel.user.userTall;
      data['user_weight'] = _getProfileResponseModel.user.userWeight;
      data['user_motivation'] = _getProfileResponseModel.user.userMotivation;
      data['user_goal_weight'] = _getProfileResponseModel.user.userGoalWeight;
      data['user_firebase'] = _getProfileResponseModel.user.userFirebase;
      data['jwt'] = _getProfileResponseModel.user.jwt;
      print("data ${json.encode(data)}");
      final response = await http.post(updateUser,
          headers: {"Accept": "application/json"}, body: json.encode(data));
      print("reg ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
          if (updateUserResponseModel.status == "1") {
            getCurrentProfile();
            _customLoader.hideLoader();
          } else {
            Utils.toast(updateUserResponseModel.message);
          }
        } else {
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            updateUserResponseModel = UpdateUserResponseModel.fromJson(result);
            Utils.toast(updateUserResponseModel.message);
            _customLoader.hideLoader();
          } else {
            Utils.toast("${response.statusCode}");
          }
        }
      } else {
        Utils.toast(generalError);
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  void loginDataStoreTOLocalStorage(result) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user = jsonEncode(LoginResponseModel.fromJson(result));
    sharedPreferences.setString(LocalStorage.loginResponseModel, user);
    sharedPreferences.setBool(LocalStorage.isLogin, true);
    isChanged();
  }

  Widget showDialogs(BuildContext context) {
    var key = GlobalKey<FormState>();
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: this.context,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    LocaleKeys.key_change_password,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontSize: 16.0),
                                  ).tr()),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                },
                                child: Icon(Icons.cancel),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, left: 15.0, right: 15.0),
                            child: Form(
                              key: key,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.only(top: 5.0),
                                      child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          style: textStyle,
                                          focusNode: _passwor,
                                          controller: _strPassword,
                                          obscureText: passwordVisible,
                                          onFieldSubmitted: (val) {
                                            setFocusNode(
                                                context: context,
                                                focusNode: _confirmPass);
                                          },
                                          textInputAction: TextInputAction.next,
                                          validator: (String value) {
                                            return fieldchecker(
                                                newPassword: value,
                                                context: context,
                                                name: LocaleKeys
                                                    .key_old_password
                                                    .tr());
                                          },
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                passwordVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: greenColor,
                                              ),
                                              onPressed: () {
                                                if (mounted)
                                                  setState(() {
                                                    passwordVisible =
                                                        !passwordVisible;
                                                  });
                                              },
                                            ),
                                            // labelText: 'Rate Of Interest',
                                            hintText: "New Password",
                                            contentPadding: EdgeInsets.fromLTRB(
                                                30.0, 10.0, 20.0, 10.0),
                                            labelStyle: textStyle,
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                              borderRadius:
                                                  BorderRadius.circular(30.0),
                                            ),
                                          ))),
                                  Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        style: textStyle,
                                        focusNode: _confirmPass,
                                        controller: _strConfirmPassword,
                                        textInputAction: TextInputAction.done,
                                        obscureText: cpasswordVisible,
                                        validator: (String value) {
                                          return passwordMatchValidator(context: context,confirmPassword: _strConfirmPassword.text,newPassword: _strPassword.text);
                                        },
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              cpasswordVisible
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: greenColor,
                                            ),
                                            onPressed: () {
                                              if (mounted)
                                                setState(() {
                                                  cpasswordVisible =
                                                      !cpasswordVisible;
                                                });
                                            },
                                          ),

                                          // labelText: 'Rate Of Interest',
                                          hintText:"Confirm Password",
                                          contentPadding: EdgeInsets.fromLTRB(
                                              30.0, 10.0, 20.0, 10.0),
                                          labelStyle: textStyle,
                                          border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.white),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  top: 30.0,
                                  left: 40.0,
                                  right: 40.0,
                                  bottom: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  minWidth: 50.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  onPressed: () => {
                                    if (key.currentState.validate()) {
                                    print("currentState"),
                                      apiCall()
                                    }
                                  },
                                  color: Colors.black,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // Replace with a Row for horizontal icon + text
                                    children: <Widget>[
                                      Text(
                                        LocaleKeys.key_submit,
                                        style: TextStyle(color: Colors.white),
                                      ).tr(),
                                    ],
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  )),
            );
          },
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  apiCall() {
    print("apiCall");
    String oldPassword = _strPassword.text;
    String newPassword = _strConfirmPassword.text;
    changepassword(newPassword);
  }

  void changepassword(String newPassword) async {
    print("changePassAPi");
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_id'] = _getProfileResponseModel.user.userId;
      data['user_email'] = _getProfileResponseModel.user.userEmail;
      data['user_old_password'] = _getProfileResponseModel.user.userPassword;
      data['user_new_password'] = newPassword;
      data['jwt'] = _getProfileResponseModel.jwt;
      print("data${json.encode(data)}");
      final response = await http.post(changePassword,
          headers: {"Authorization": "Bearer " + token},
          body: json.encode(data));
print("responsebody${response.body}  ${response.statusCode}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          _customLoader.hideLoader();
          setState(() {
              var result = json.decode(response.body);
              _changePasswordResponseModel =
                  ChangePasswordResponseModel.fromJson(result);
              if (_changePasswordResponseModel.status == "1") {
                Utils.toast("my detail ${_changePasswordResponseModel.message} ");
                Navigator.of(this.context, rootNavigator: true).pop('dialog');
                Utils.hideKeyboard(context);
                clearData();
                _userLogin(_getProfileResponseModel.user.userEmail,newPassword);
              } else {
                Utils.toast(_changePasswordResponseModel.message);
              }
            });
        } else {
          _customLoader.hideLoader();
          if (response.statusCode == 400) {
            var result = json.decode(response.body);
            _changePasswordResponseModel =
                ChangePasswordResponseModel.fromJson(result);
            Utils.toast("${_changePasswordResponseModel.message} ");
            Utils.hideKeyboard(context);
            clearData();
          } else {
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

  void clearData() {
    _strPassword.clear();
    _strConfirmPassword.clear();
  }

  _userLogin(String email, String password) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      await getSecurityLevelToken();
      var tokens = _authTokenGenerationResposeModel.jwt;
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_email'] = email;
      data['user_password'] = password;

      final response = await http.post(loginUser,
          headers: {"Accept": "application/json","Authorization":"Bearer ${tokens}"},
          body: json.encode(data));
      print("logib ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          _customLoader.hideLoader();
          var result = json.decode(response.body);
          _loginResponseModel = LoginResponseModel.fromJson(result);
          if (_loginResponseModel.status == "1") {
            _customLoader.hideLoader();
            loginDataStoreTOLocalStorage(result);
          } else {
            _customLoader.hideLoader();
            Utils.toast(_loginResponseModel.message);
          }
        } else {
          _customLoader.hideLoader();
          Utils.toast("${response.statusCode} ");
        }
      } else {
        _customLoader.hideLoader();
        Utils.toast(generalError);
        _customLoader.hideLoader();
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

/*  *//*--------------------------------------------- login data store in local storage ------------------------------------------------*//*
  void loginDataStoreTOLocalStorage(result) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String user = jsonEncode(LoginResponseModel.fromJson(result));
    sharedPreferences.setString(LocalStorage.loginResponseModel, user);
    sharedPreferences.setBool(LocalStorage.isLogin, true);
    getDataFromShared();
  }


  *//*--------------------------------------------- get data from Local Storage -------------------------------------------------------*//*

  void getDataFromShared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map userMap = jsonDecode(
        sharedPreferences.getString(LocalStorage.loginResponseModel));
    var user = LoginResponseModel.fromJson(userMap);
  }*/

  Future<void> getSecurityLevelToken() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['token_username'] = "HealthyBox_User";
      data['token_password'] = "1bV3LzgA8Box01iJU6Q";

      final response = await http.post(endPointTokenGeneration,
          headers: {"Accept": "application/json"},
          body: json.encode(data));
      print("logib ${response.body}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          var result = json.decode(response.body);
          _authTokenGenerationResposeModel = AuthTokenGenerationResposeModel.fromJson(result);
          if (_authTokenGenerationResposeModel.status == "1") {


            //  loginDataStoreTOLocalStorage(result);
          } else {
            Utils.toast(_loginResponseModel.message);
          }
        } else {
          Utils.toast("Something went wrong, Server under maintance..");
        }
      } else {
        Utils.toast(generalError);
        _customLoader.hideLoader();
      }
    } else {
      Utils.toast(noInternetError);
    }
  }

  Future<void> _clearAllData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(LocalStorage.loginResponseModel, null);
    sharedPreferences.setBool(LocalStorage.isLogin, false);
    Utils.pushRemove(context, LoginScreen());
    Utils.toast("user logout");
  }
}
