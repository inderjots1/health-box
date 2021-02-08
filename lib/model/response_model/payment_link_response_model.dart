class PaymentLinkResponseModel {
  String message;
  String linkPayment;
  String status;

  PaymentLinkResponseModel({this.message, this.linkPayment, this.status});

  PaymentLinkResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    linkPayment = json['link_payment'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['link_payment'] = this.linkPayment;
    data['status'] = this.status;
    return data;
  }
}
