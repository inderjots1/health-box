


import 'dart:core';

import 'package:flutter/cupertino.dart';

const   baseUrl = "https://www.eblock6.com/healthbox/webservices/api/";

const endPointAllProgram ="GetPrograms.php";

void setFocusNode({
  @required BuildContext context,
  @required FocusNode focusNode,
}) {
  FocusScope.of(context).requestFocus(focusNode);
}