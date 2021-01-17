class AuthTokenGenerationResposeModel {
  String status;
  String jwt;
  String message;

  AuthTokenGenerationResposeModel({this.status, this.jwt, this.message});

  AuthTokenGenerationResposeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    jwt = json['jwt'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['jwt'] = this.jwt;
    data['message'] = this.message;
    return data;
  }
}