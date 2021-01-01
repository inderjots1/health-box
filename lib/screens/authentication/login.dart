import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/screens/authentication/forgot_password.dart';
import 'package:health_box/screens/authentication/register.dart';
import 'package:health_box/screens/home/homeScreen.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/widgets/button.dart';

import '../../constant.dart';
import 'package:easy_localization/easy_localization.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  FocusNode emailNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();

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
                height: 30.0,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: RoundedButtonWidget(
                    buttonColor: greenColor,
                    buttonText: LocaleKeys.key_login,
                    textColor: Colors.white,
                    onPressed: () {
                      Utils.pushReplacement(context, HomeScreen());
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
    return Form(
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
                    onTap: () {},
                    child: Icon(
                      Icons.visibility_off,
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
}
