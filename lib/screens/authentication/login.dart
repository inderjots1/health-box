import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/auth_token.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/screens/authentication/forgot_password.dart';
import 'package:health_box/screens/authentication/register.dart';
import 'package:health_box/screens/home/homeScreen.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  AuthTokenGenerationResposeModel  _authTokenGenerationResposeModel = new AuthTokenGenerationResposeModel();
  FocusNode emailNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();
  LoginResponseModel _loginResponseModel = new LoginResponseModel();
  CustomLoader _customLoader = new CustomLoader();
  bool ispassowrd = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
    padding: EdgeInsets.all(10.0),
    child: Container(
      color: Colors.white,
      child: ListView(
        children: [
          _upperUI(),
          _form(),
          SizedBox(
            height: 30.0,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: RoundedButtonWidget(
                buttonColor: greenColor,
                buttonText: LocaleKeys.key_login,
                textColor: Colors.white,
                onPressed: () {
                  if(_formKey.currentState.validate()){
                   _userLogin(_emailEditingController.text.trim(), _passwordEditingController.text.trim());
                  }

                },
                isIconDisplay: false,
              )),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0, right: 50.0),
            child: RoundedButtonWidget(
              buttonColor: grey,
              buttonText: LocaleKeys.key_create_account,
              textColor: Colors.white,
              onPressed: () {

                Utils.pushReplacement(context, RegisterScreen());

              },
              isIconDisplay: false,
            ),
          )
        ],
      ),
    ),
      ),
    );
  }

  Widget _upperUI() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        children: [
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
          Row(
            children: [
              Image(
                image: AssetImage(Assets.yogaa),
                height: 74.5,
                width: 80.0,
              ),
              Expanded(
                  child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Text(
                    LocaleKeys.key_welcome_back,
                    style: TextStyle(fontSize: 20.0),
                  ).tr(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 2,
                    color: greenColor,
                  )
                ],
              )),
              Image(
                image: AssetImage(Assets.fitness),
                height: 95.5,
                width: 80.0,
              )
            ],
          )
        ],
      ),
    );
  }

  _form() {
    return Form(key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.text,
                focusNode: emailNode,
                controller: _emailEditingController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  setFocusNode(context: context, focusNode: passwordNode);
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Oops! please enter email id';
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: s10color,
                  // labelText: 'Rate Of Interest',
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: s10color, width: 1.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: s10color, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: s10color, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                focusNode: passwordNode,
                obscureText: ispassowrd,
                controller: _passwordEditingController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {},
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Oops! please enter password';
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: s10color,
                  // labelText: 'Rate Of Interest',
                  hintText: "Password",
                  suffixIcon: InkWell(
                    onTap: () {
                     setState(() {
                       ispassowrd = !ispassowrd;
                     });
                    },
                    child: Icon(
                      ispassowrd ? Icons.visibility_off
                        : Icons.visibility,
                      color: grey,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: s10color, width: 1.0),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 20.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: s10color, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: s10color, width: 1.0),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
            SizedBox(height: 15.0,),
            Align(alignment: Alignment.centerRight,child:InkWell(onTap: (){
              Utils.pushReplacement(context, ForgotPassword());
            },child: Text(LocaleKeys.key_forgot_password).tr(),),)
          ],
        ),
      ),
    );
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
            Utils.pushRemove(context, HomeScreen());
            Utils.toast(_loginResponseModel.message);
             loginDataStoreTOLocalStorage(result);
          } else  if(_loginResponseModel.status == "0"){
            _customLoader.hideLoader();
            print("fla");
            Utils.toast("${_loginResponseModel.message}");
          }
        } else {
          _customLoader.hideLoader();
          var result = json.decode(response.body);
          _loginResponseModel = LoginResponseModel.fromJson(result);
          if(response.statusCode==401){
            Utils.toast(_loginResponseModel.message);

          }else {
            Utils.toast("${response.statusCode} ");
          }
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
}
