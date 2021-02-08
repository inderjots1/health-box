import 'dart:async';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_box/generated/locale_keys.g.dart';
import 'package:health_box/model/response_model/BuyResponseModel.dart';
import 'package:health_box/model/response_model/addressResponseModel.dart';
import 'package:health_box/model/response_model/loginResponseMode.dart';
import 'package:health_box/model/response_model/payment_link_response_model.dart';
import 'package:health_box/model/response_model/payment_result_response_model.dart';
import 'package:health_box/screens/order/mypaymentPage.dart';
import 'package:health_box/screens/order/sucessMessage.dart';
import 'package:health_box/utitlity/CustomLoader.dart';
import 'package:health_box/utitlity/LocalStorage.dart';
import 'package:health_box/utitlity/Utils.dart';
import 'package:http/http.dart' as http;
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '../../constant.dart';

class Payment extends StatefulWidget {
  String programId, programCost, programDuration;

  Payment(this.programId, this.programCost, this.programDuration);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNewAdressState();
  }
}

class AddNewAdressState extends State<Payment> {
  int selectedRadioTile;
  bool selected1 = false;
  bool selected2 = false;
  bool isSelected = false;
  var addressType = "";
  var token, guestId;
  int _selectedIndex;
  DateTime selectedDate = DateTime.now();

  var _formKey = GlobalKey<FormState>();
  TextEditingController _controllerBlock;
  TextEditingController _controllerAddress;
  TextEditingController _controllerStreetAdress1;
  TextEditingController _controllerStreetAdress2;
  TextEditingController _controllerDistrict;
  TextEditingController _controllerCountry;
  TextEditingController _controllerCity;
  TextEditingController _controllerMobile;
  TextEditingController _controllerZipCode;
  TextEditingController _noteController;
  TextEditingController _avenusController;
  TextEditingController _houseNumberController;

  // Focus Nodes
  final FocusNode _block = new FocusNode();
  final FocusNode _addressName = new FocusNode();
  final FocusNode _streetAddress1 = new FocusNode();
  final FocusNode _streetAddress2 = new FocusNode();
  final FocusNode _district = new FocusNode();
  final FocusNode _mobile = new FocusNode();
  final FocusNode _city = new FocusNode();
  final FocusNode _country = new FocusNode();
  final FocusNode _zipcode = new FocusNode();
  final FocusNode _note = new FocusNode();
  final FocusNode _avenusNode = new FocusNode();
  final FocusNode _houseNumberNode = new FocusNode();

  TextStyle textStyle =
      TextStyle(fontSize: 16.0, color: Colors.black, fontFamily: 'Roboto');

  AddressResponseModel _addressResponseModel = new AddressResponseModel();
  CustomLoader _customLoader = new CustomLoader();

  String strDistict, strAreadID, strStartDate;
  var customFormat = DateFormat('yyyy-MM-dd');
  PaymentLinkResponseModel _paymentLinkResponseModel = new PaymentLinkResponseModel();

  List<AreaItem> _companies;
  List<DropdownMenuItem<AreaItem>> _dropdownMenuItems;
  AreaItem _selectedCompany;
  BuyResponseModel _buyResponseModel = new BuyResponseModel();
  LoginResponseModel user = new LoginResponseModel();
  PaymentResultResponseModel _paymentResultResponseModel = new PaymentResultResponseModel();

  @override
  void initState() {
    _controllerBlock = TextEditingController();
    _controllerAddress = TextEditingController();
    _controllerStreetAdress1 = TextEditingController();
    _controllerStreetAdress2 = TextEditingController();
    _controllerDistrict = TextEditingController();
    _controllerMobile = TextEditingController();
    _controllerZipCode = TextEditingController();
    _noteController = TextEditingController();
    _avenusController = TextEditingController();
    _houseNumberController = TextEditingController();
    /* _controllerCountry = TextEditingController();*/
    _controllerCity = TextEditingController();
    selectedRadioTile = 0;
    getDataFromShared();
    getAllDistrict();
    super.initState();
  }

  _onSelected(int index) {
    setState(() => {_selectedIndex = index});
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

  Future<void> getAllDistrict() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      final response = await http
          .post(getAreaEndPoint, headers: {"Authorization": "Bearer $token"});
      print("userData${response.body}");
      if (response.body != null) {
        if (response.statusCode == 200) {
          if (mounted)
            setState(() {
              var result = json.decode(response.body);
              _addressResponseModel = AddressResponseModel.fromJson(result);
              if (_addressResponseModel != true) {
                _addressResponseModel = _addressResponseModel;
                _companies = _addressResponseModel.areaItem;
                _dropdownMenuItems = buildDropdownMenuItems(_companies);
                _selectedCompany = _dropdownMenuItems[0].value;
                strAreadID = _dropdownMenuItems[0].value.areaId;
                strDistict =
                    EasyLocalization.of(context).locale.languageCode == "en"
                        ? _dropdownMenuItems[0].value.areaNameEng
                        : _dropdownMenuItems[0].value.areaNameAr;
              } else {
                Utils.toast("Server Error");
              }
            });
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

  /*--------------------------------------------- categroy DropDown SetUp ---------------------------------------*/

  List<DropdownMenuItem<AreaItem>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<AreaItem>> items = List();
    for (AreaItem company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              EasyLocalization.of(context).locale.languageCode == "en"
                  ? company.areaNameEng
                  : company.areaNameAr,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        ),
      );
    }
    return items;
  }

  /*------------------------------------------ on change category drop down ------------------------------------*/

  onChangeDropdownItem(AreaItem selectedCompany) {
    if (mounted)
      setState(() {
        _selectedCompany = selectedCompany;
        strDistict = EasyLocalization.of(context).locale.languageCode == "en"
            ? selectedCompany.areaNameEng
            : selectedCompany.areaNameAr;
        print("districtclick ${strDistict}");
        strAreadID = _dropdownMenuItems[0].value.areaId;
        FocusScope.of(context).unfocus();
      });
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
              LocaleKeys.key_checkout,
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
                              left: 5.0, right: 5.0, top: 10.0, bottom: 1.0),
                          child: Column(
                            children: <Widget>[
                          Container(child: Marquee(
                            text: 'You cannot purchase on Friday',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 20.0,
                            velocity: 100.0,
                            pauseAfterRound: Duration(seconds: 1),
                            showFadingOnlyWhenScrolling: true,
                            fadingEdgeStartFraction: 0.1,
                            fadingEdgeEndFraction: 0.1,
                            numberOfRounds: 3,
                            startPadding: 10.0,
                            accelerationDuration: Duration(seconds: 1),
                            accelerationCurve: Curves.linear,
                            decelerationDuration: Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          ),height: 20.0,),
                              /* street 1*/
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _controllerStreetAdress1,
                                  focusNode: _streetAddress1,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context, focusNode: _avenusNode);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return LocaleKeys.key_empty_street1_error
                                          .tr();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_street1.tr(),
                                      labelText: LocaleKeys.key_street1.tr(),
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
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _avenusController,
                                  focusNode: _avenusNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context, focusNode: _block);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return "please add avenu";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Avenu Number",
                                      labelText: "Avenu Number",
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
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _houseNumberController,
                                  focusNode: _houseNumberNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context, focusNode: _block);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return "please enter house number";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: "House Number",
                                      labelText: "House Number",
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
                                  controller: _controllerBlock,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _block,
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context,
                                        focusNode: _addressName);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return LocaleKeys.key_empty_name_error
                                          .tr();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_name.tr(),
                                      labelText: LocaleKeys.key_name.tr(),
                                      labelStyle: textStyle,
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      )),
                                ),
                              ),

                              /*district */

                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10.0, left: 15.0, right: 15.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      LocaleKeys.key_area,
                                      style: textStyle,
                                    ).tr(),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, left: 15.0, right: 15.0),
                                child: DropdownButton(
                                  hint:
                                      Text(LocaleKeys.key_select_district).tr(),
                                  isExpanded: true,
                                  value: _selectedCompany,
                                  items: _dropdownMenuItems,
                                  onChanged: onChangeDropdownItem,
                                ),
                              ),
                              /*city */

                              /* Phone*/
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.text,
                                  controller: _controllerMobile,
                                  focusNode: _mobile,
                                  textInputAction: TextInputAction.next,
                                  onTap: () async {
                                    showStartPicker(context);
                                  },
                                  onFieldSubmitted: (val) {
                                    setFocusNode(
                                        context: context, focusNode: _zipcode);
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return "please select Day";
                                    }else if(selectedDate.weekday==5){
                                      return "You cannot purchase on Friday";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_mobile.tr(),
                                      labelText: LocaleKeys.key_mobile.tr(),
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
                                    top: 5.0, left: 20.0, right: 20.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  controller: _noteController,
                                  focusNode: _note,
                                  textInputAction: TextInputAction.done,

                                  onFieldSubmitted: (val) {
                                   Focus.of(context).unfocus();
                                  },
                                  validator: (String userValur) {
                                    if (userValur.isEmpty) {
                                      return LocaleKeys.key_note_empty
                                          .tr();
                                    }
                                  },
                                  decoration: InputDecoration(
                                      hintText: LocaleKeys.key_note.tr(),
                                      labelText: LocaleKeys.key_note.tr(),
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
                      "Pay ${widget.programCost}KD",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Roboto'),
                    ).tr(),
                    elevation: 6.0,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        paymentlinkeGeneration();
                        /*addAddress();*/
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

  void addAddress(String status) {
    String _block = _controllerBlock.text;
    String _address = _controllerAddress.text;
    String _street1 = _controllerStreetAdress1.text;
    String _street2 = _controllerStreetAdress2.text;
    String _city = _controllerCity.text;
    String _district = _controllerDistrict.text;
    String _country = "";
    String _mobile = _controllerMobile.text;
    String _zipCode = _controllerZipCode.text;

    addAddressAdpCall(_block, _address, _street1, _street2, _city, _district,
        _country, _mobile, _zipCode,status);
  }

  /*---------------------------------------------- Add address api call -----------------------------------------------------*/

  addAddressAdpCall(
      String name,
      String address,
      String street1,
      String street2,
      String city,
      String state,
      String country,
      String mobile,
      String zipcode, String status) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {

      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['user_email'] = user.user.userEmail;
      data['user_password'] = user.user.userPassword;
      data['jwt'] = user.jwt;
      data['program_id'] = widget.programId;
      data['user_id'] = user.user.userId;
      data['notes'] = _noteController.text;
      data['area_id'] = strAreadID;
      data['block_num'] = strDistict;
      data['street_num'] = _controllerStreetAdress1.text;
      data['avenus_num'] = _avenusController.text;
      data['house_num'] = _houseNumberController.text;
      data['start_date'] = strStartDate;
      data['program_duration'] = widget.programDuration;
      data['payment_status_id'] = status;
      data['TranID'] = _paymentResultResponseModel.tranID;
      data['order_id'] = _paymentResultResponseModel.orderID;
      data['PaymentID'] = _paymentResultResponseModel.paymentID;
      data['TrackID'] = _paymentResultResponseModel.trackID;
      data['price'] = widget.programCost;

      print("encode json ${json.encode(data)}");
      final response = await http.post(addProgramEndPoint,
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
              _buyResponseModel = BuyResponseModel.fromJson(result);
              if (_buyResponseModel.status == "1") {
                _customLoader.hideLoader();
                Utils.pushReplacement(context, SucessMessage());

              } else {
                _customLoader.hideLoader();
                Utils.toast(_buyResponseModel.message);
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
    _controllerBlock.dispose();
    _controllerAddress.dispose();
    _controllerStreetAdress1.dispose();
    _controllerStreetAdress2.dispose();
    _controllerDistrict.dispose();
    _controllerMobile.dispose();
    _controllerZipCode.dispose();
    _controllerCity.dispose();
    /* _controllerCountry.dispose();*/
    super.dispose();
  }

  Future<Null> showStartPicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1918),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate) if (mounted)
      setState(() {
        selectedDate = picked;
        if(selectedDate.weekday==5) {
          Utils.toast("Friday");
        }
        strStartDate = customFormat.format(selectedDate);
        _controllerMobile.text = strStartDate;
      });
  }

  Future<void> paymentlinkeGeneration() async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['total_price'] = widget.programCost;
      data['user_name'] = user.user.userName;
      data['user_email'] = user.user.userEmail;
      data['user_telep'] = user.user.userTelep;


      print("encode json ${json.encode(data)}");
      final response = await http.post(paymentApi,
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer " + token
          },
          body: json.encode(data));

      print("Address ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (mounted)
          setState(() async {
            if (response.statusCode == 200) {
              var result = json.decode(response.body);
              _paymentLinkResponseModel = PaymentLinkResponseModel.fromJson(result);
              if (_paymentLinkResponseModel.status == "1") {
                _customLoader.hideLoader();
              var myurlfinal = await Navigator.push(
                    context, MaterialPageRoute(builder: (BuildContext) =>  MyPaymentPage(_paymentLinkResponseModel.linkPayment)));
print ("mypaymentUrl ${myurlfinal}");
hitapiStatusIdentify(myurlfinal);
              } else {
                _customLoader.hideLoader();
                Utils.toast(_buyResponseModel.message);
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

  Future<void> hitapiStatusIdentify(myurlfinal) async {
    bool isConnected = await isConnectedToInternet();
    if (isConnected == true) {
      _customLoader.showLoader(context);

      final response = await http.post(myurlfinal);

      print("Address ${response.body}");
      if (response.body != null) {
        _customLoader.hideLoader();
        if (mounted)
          setState(() async {
            if (response.statusCode == 200) {
              var result = json.decode(response.body);
              _paymentResultResponseModel = PaymentResultResponseModel.fromJson(result);
              if (_paymentResultResponseModel.status == "1") {
                addAddress("3");
              } else {
                addAddress("4");
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
}
