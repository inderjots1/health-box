import 'package:flutter/cupertino.dart';

bool isEmailFormatValid(String email) {
  String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(p);
  return regExp.hasMatch(email);
}

// Validates email field

String emailValidator(
    {@required String email, @required BuildContext context}) {
  if (email.trim().isEmpty) {
    return "Oops! Enter email - id";
  } else if (!isEmailFormatValid(email.trim())) {
    return "Oops! Enter valid email - id";
  }
  return null;
}

// Validates password complexity
bool isPasswordComplexEnough(String password) {
  String p = r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$";
  RegExp regExp = new RegExp(p);

  return regExp.hasMatch(password);
}

// Validates "new password" field
String passwordValidator(
    {@required String newPassword, @required BuildContext context}) {
  if (newPassword.isEmpty) {
    return "Oops! Enter password";
  }
  return null;
}

// Validates "new password" field
String passwordMatchValidator(
    {@required String newPassword,
    @required String confirmPassword,
    @required BuildContext context}) {
  if (newPassword.isEmpty) {
    return "Oops! Enter password";
  }  else if (newPassword != confirmPassword) {
    return "Oops! password not match";
  }
  return null;
}

// Validates "new password" field
String fieldchecker(
    {@required String newPassword,
      @required String name,
    @required BuildContext context}) {
  if (newPassword.isEmpty) {
    return "Oops! please enter ${name}";
  }
  return null;
}
