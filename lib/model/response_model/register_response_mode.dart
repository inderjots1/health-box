import 'package:health_box/model/data_model/UserDetailDataModel.dart';

class RegisterResponseModel {
  String status;
  String message;
  UserDetailDataModel user;
  String jwt;

  RegisterResponseModel({this.status, this.message, this.user, this.jwt});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new UserDetailDataModel.fromJson(json['user']) : null;
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    data['jwt'] = this.jwt;
    return data;
  }
}