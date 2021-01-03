class ClearTokenResponseModel {
  String status;
  String message;
  String jwt;

  ClearTokenResponseModel({this.status, this.message, this.jwt});

  ClearTokenResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['jwt'] = this.jwt;
    return data;
  }
}