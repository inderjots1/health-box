import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/BuyResponseModel.dart';
import 'package:health_box/model/response_model/addressResponseModel.dart';
import 'package:health_box/model/response_model/feedbackResponse.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/screens/order/sucessMessage.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../../constant.dart';

class Feedbacks extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddNewAdressState();
  }
}

class AddNewAdressState extends State<Feedbacks> {
  int selectedRadioTile;
  bool selected1 = false;
  bool selected2 = false;
  bool isSelected = false;
  var addressType = "";
  var token, guestId;
  int _selectedIndex;
  DateTime selectedDate = DateTime.now();

  var _formKey = GlobalKey<FormState>();
  TextEditingController _nameController;
  TextEditingController titileController;
  TextEditingController _messsageController;

FeedbackResponseModel _feedbackResponseModel = new FeedbackResponseModel();
  // Focus Nodes
  final FocusNode _name = new FocusNode();
  final FocusNode _messsage = new FocusNode();
  final FocusNode titile = new FocusNode();


  TextStyle textStyle =
      TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Roboto');

  AddressResponseModel _addressResponseModel = new AddressResponseModel();
  CustomLoader _customLoader = new CustomLoader();

  String strDistict, strAreadID, strStartDate;
  var customFormat = DateFormat('yyyy-MM-dd');

  List<AreaItem> _companies;
  List<DropdownMenuItem<AreaItem>> _dropdownMenuItems;
  AreaItem _selectedCompany;
  BuyResponseModel _buyResponseModel = new BuyResponseModel();
  LoginResponseModel user = new LoginResponseModel();

  @override
  void initState() {
    _nameController = TextEditingController();
    titileController = TextEditingController();
    _messsageController = TextEditingController();
    getDataFromShared();
    //getAllDistrict();
    super.initState();
  }


  /*---------------------------------------- get data from Local Storage -------------------------------------*/

  getDataFromShared() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString(LocalStorage.loginResponseModel) != null) {
      Map userMap = jsonDecode(
          sharedPreferences.getString(LocalStorage.loginResponseModel));
      user = LoginResponseModel.fromJson(userMap);
      token = user.jwt;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              LocaleKeys.key_feedback,
              style: TextStyle(color: Colors.black),
            ).tr(),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 50.0),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.0, right: 5.0, top: 1.0, bottom: 1.0),
                          child: Column(
                            children: <Widget>[
                              /* street 1*/
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _nameController,
                                  focusNode: _name,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context, focusNode: titile);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return LocaleKeys.key_empty_name_error
                                          .tr();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_names.tr(),
                                      labelText: LocaleKeys.key_names.tr(),
                                      labelStyle: textStyle,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      )),

                                  /* decoration: InputDecoration(
                                labelText: 'Principal',
                                hintText: 'Enter Principal Amount',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                prefixIcon: const Icon(
                                  Icons.attach_money,
                                  color: Colors.pink,
                                ),
                              ),*/
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: titileController,
                                  textInputAction: TextInputAction.next,
                                  focusNode: titile,
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context,
                                        focusNode: _messsage);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return LocaleKeys.key_title_empty
                                          .tr();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_title.tr(),
                                      labelText: LocaleKeys.key_title.tr(),
                                      labelStyle: textStyle,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      )),
                                ),
                              ),

                              /*district */


                              /*city */

                              /* Phone*/
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.multiline,
                                  controller: _messsageController,
                                  focusNode: _messsage,
                                  textInputAction: TextInputAction.done,

                                  onFieldSubmitted: (val) {
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return LocaleKeys.key_no_message
                                          .tr();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_message.tr(),
                                      labelText: LocaleKeys.key_message.tr(),
                                      labelStyle: textStyle,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      )),

                                  /* decoration: InputDecoration(
                                labelText: 'Principal',
                                hintText: 'Enter Principal Amount',
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.pink)),
                                prefixIcon: const Icon(
                                  Icons.attach_money,
                                  color: Colors.pink,
                                ),
                              ),*/
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    height: 45.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    color: Colors.black,
                    minWidth: 200.0,
                    child: Text(
                      LocaleKeys.key_submit,
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Roboto'),
                    ).tr(),
                    elevation: 6.0,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        addAddress();
                        print("click");
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  void addAddress() {
    String name = _nameController.text;
    String title = titileController.text;
    String message = _messsageController.text;

    addAddressAdpCall(name, title, message,);
  }

  /*---------------------------------------------- Add address api call -----------------------------------------------------*/

  addAddressAdpCall(
      String name,
      String title,
      String message,
    ) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['name'] = user.user.userEmail;
      data['feed_title'] = user.user.userPassword;
      data['feed_message'] = user.jwt;

      print("encode json ${json.encode(data)}");
      final response = await http.post(addFeeds,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
          },
          body: json.encode(data));

      print("Address ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (mounted)
          setState(() {
            if (response.statusCode == 200) {
              var result = json.decode(response.body);
              _feedbackResponseModel = FeedbackResponseModel.fromJson(result);
              if (_feedbackResponseModel.status == "1") {
                _customLoader.hideLoader();
                Utils.toast(_feedbackResponseModel.message);
_nameController.clear();
titileController.clear();
_messsageController.clear();
              } else {
                _customLoader.hideLoader();
                Utils.toast(_feedbackResponseModel.message);
              }
            } else {
              _customLoader.hideLoader();
              if (response.statusCode == 401) {
              } else {
                Utils.toast("${response.statusCode} ");
              }
            }
          });
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
    _nameController.dispose();
    titileController.dispose();
    _messsageController.dispose();

    /* _controllerCountry.dispose();*/
    super.dispose();
  }

}
