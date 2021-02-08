import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/constants/assets.dart';
import 'package:health_box/constants/colors.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/screens/onboarding/onboarding1.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:health_box/utitlity/Validator.dart';
import 'package:health_box/widgets/button.dart';

import '../../constant.dart';
import 'package:easy_localization/easy_localization.dart';

import 'login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameEditingController = new TextEditingController();
  TextEditingController _emailEditingController = new TextEditingController();
  TextEditingController _phoneEditingController = new TextEditingController();
  TextEditingController _passwordEditingController =
      new TextEditingController();
  TextEditingController _confirmPasswordEditingController =
      new TextEditingController();
  FocusNode nameNode = new FocusNode();
  FocusNode emailNode = new FocusNode();
  FocusNode phoneNode = new FocusNode();
  FocusNode passwordNode = new FocusNode();
  FocusNode confirmPasswordNode = new FocusNode();

  bool passwordVisible = true;
  bool cpasswordVisible = true;
  String myPassword;

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
                    buttonText: LocaleKeys.key_signup,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Utils.pushReplacement(
                            context,
                            OnBoarding1(
                                _nameEditingController.text,
                                _emailEditingController.text,
                                _passwordEditingController.text,_phoneEditingController.text));
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
                  buttonText: LocaleKeys.key_already_account,
                  textColor: Colors.white,
                  onPressed: () {
                    Utils.pushReplacement(context, LoginScreen());
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
                    LocaleKeys.key_create_account,
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
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 50.0),
        child: Column(
          children: [
            TextFormField(
                keyboardType: TextInputType.text,
                focusNode: nameNode,
                controller: _nameEditingController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  setFocusNode(context: context, focusNode: emailNode);
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Oops! please enter name';
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: s10color,
                  // labelText: 'Rate Of Interest',
                  hintText: "Name",
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
                focusNode: emailNode,
                controller: _emailEditingController,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  setFocusNode(context: context, focusNode: phoneNode);
                },
                validator: (String value) {
                  return emailValidator(context: context, email: value);
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
                keyboardType: TextInputType.number,
                focusNode: phoneNode,
                controller: _phoneEditingController,
                maxLength: 8,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  setFocusNode(context: context, focusNode: passwordNode);
                },
                validator: (String value) {
                  return fieldchecker(
                      context: context,
                      name: "Phone Number",
                      newPassword: value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: s10color,
                  // labelText: 'Rate Of Interest',
                  hintText: "Phone Number",
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
                obscureText: passwordVisible,
                onFieldSubmitted: (val) {
                  setFocusNode(
                      context: context, focusNode: confirmPasswordNode);
                },
                validator: (String value) {
                  myPassword = value;
                  return passwordValidator(
                      newPassword: value, context: context);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: s10color,
                  // labelText: 'Rate Of Interest',
                  hintText: "Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility_off : Icons.visibility,
                      color: greenColor,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
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
            SizedBox(
              height: 15.0,
            ),
            TextFormField(
                keyboardType: TextInputType.text,
                focusNode: confirmPasswordNode,
                controller: _confirmPasswordEditingController,
                textInputAction: TextInputAction.next,
                obscureText: cpasswordVisible,
                onFieldSubmitted: (val) {},
                validator: (String value) {
                  return passwordMatchValidator(
                      newPassword: myPassword,
                      confirmPassword: value,
                      context: context);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: s10color,
                  // labelText: 'Rate Of Interest',
                  hintText: "Confirm Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      cpasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: greenColor,
                    ),
                    onPressed: () {
                      setState(() {
                        cpasswordVisible = !cpasswordVisible;
                      });
                    },
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
                ))
          ],
        ),
      ),
    );
  }
}
