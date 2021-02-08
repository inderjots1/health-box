import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/auth_token.dart';
import 'package:health_box/model/response_model/forgot_password_response_model.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

import '../../constant.dart';
import 'new_passoword.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';


class ForgotPassword extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<ForgotPassword> {
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  FocusNode emailNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();
  CustomLoader _customLoader = new CustomLoader();
  AuthTokenGenerationResposeModel _authTokenGenerationResposeModel = new AuthTokenGenerationResposeModel();
  ForgotPasswordResponseModel _forgotPasswordResponseModel = new ForgotPasswordResponseModel();

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
              _upperUI(),
              _form(),
              SizedBox(
                height: 60.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: RoundedButtonWidget(
                    buttonColor: greenColor,
                    buttonText: LocaleKeys.key_next,
                    textColor: Colors.white,
                    onPressed: () {
                      forgotPass(_emailEditingController.text);
                    },
                    isIconDisplay: false,
                  )),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _upperUI() {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Utils.finishScreen(context);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  _form() {
    return Form(
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 80.0),
        child: Column(
          children: [

            Text(LocaleKeys.key_forgot_password,style: TextStyle(fontSize: 30.0),).tr(),
            SizedBox(height: 10.0,),
            Text(LocaleKeys.key_forgot_password_text,textAlign: TextAlign.center
              ,style: TextStyle(fontSize: 15.0),).tr(),
            SizedBox(height: 50.0,),
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
          ],
        ),
      ),
    );
  }

  forgotPass(String email) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      await getSecurityLevelToken();
      var tokens = _authTokenGenerationResposeModel.jwt;
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_email'] = email;
      data['lang'] = "ar";

      final response = await http.post(forgotPassword,
          headers: {"Accept": "application/json","Authorization":"Bearer ${tokens}"},
          body: json.encode(data));
      print("logib ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (response.statusCode == 200) {
          _customLoader.hideLoader();
          var result = json.decode(response.body);
          _forgotPasswordResponseModel = ForgotPasswordResponseModel.fromJson(result);
          if (_forgotPasswordResponseModel.status == "1") {
            _customLoader.hideLoader();

            Utils.toast(_forgotPasswordResponseModel.message);
          Navigator.pop(context);
          } else {
            _customLoader.hideLoader();
            Utils.toast(_forgotPasswordResponseModel.message);
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
            Utils.toast(_authTokenGenerationResposeModel.message);
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _customLoader.hideLoader();
  }
}
