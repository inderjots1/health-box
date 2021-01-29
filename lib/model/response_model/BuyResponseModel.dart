class BuyResponseModel {
  String message;
  String status;
  String jwt;

  BuyResponseModel({this.message, this.status, this.jwt});

  BuyResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    data['jwt'] = this.jwt;
    return data;
  }
}