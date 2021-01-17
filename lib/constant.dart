


import 'dart:core';
import 'dart:io';

import 'package:flutter/cupertino.dart';

const   baseUrl = "http://healthyboxq8.com/api/webservices/api/";

const endPointTokenGeneration =baseUrl+"autherization.php";
const endPointAllProgram ="GetPrograms.php";
const registerUser = baseUrl+"CreateUser.php";
const loginUser =baseUrl+"LoginUser.php";
const clearToken =baseUrl+"ClearToken.php";
const updateUser =baseUrl+"UpdateUser.php";

void setFocusNode({
  @required BuildContext context,
  @required FocusNode focusNode,
}) {
  FocusScope.of(context).requestFocus(focusNode);
}


// internet checker
Future<bool> isConnectedToInternet() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(const Duration(seconds: 5));
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } catch (_) {
    return false;
  }
}

 const String noInternetError =
    "Oops! Your internet is gone. Please check your internet connection";
 const String generalError = "Something went wrong, please try again";
 const String emptyStores= "Oops! no Stores are available ";
 const String emptyAucStores= "Oops! no Auction Stores are available ";
