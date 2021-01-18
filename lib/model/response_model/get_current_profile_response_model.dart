import 'package:health_box/model/data_model/get_profile_data_model.dart';

class GetProfileResponseModel {
  String status;
  String message;
  String jwt;
  GetProfileDataModel user;

  GetProfileResponseModel({this.status, this.message, this.jwt, this.user});

  GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jwt = json['jwt'];
    user = json['user'] != null ? new GetProfileDataModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['jwt'] = this.jwt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}