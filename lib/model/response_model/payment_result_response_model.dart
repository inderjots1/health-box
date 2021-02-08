class PaymentResultResponseModel {
  String paymentID;
  String result;
  String tranID;
  String trackID;
  String orderID;
  String status;

  PaymentResultResponseModel(
      {this.paymentID,
        this.result,
        this.tranID,
        this.trackID,
        this.orderID,
        this.status});

  PaymentResultResponseModel.fromJson(Map<String, dynamic> json) {
    paymentID = json['PaymentID'];
    result = json['Result'];
    tranID = json['TranID'];
    trackID = json['TrackID'];
    orderID = json['OrderID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PaymentID'] = this.paymentID;
    data['Result'] = this.result;
    data['TranID'] = this.tranID;
    data['TrackID'] = this.trackID;
    data['OrderID'] = this.orderID;
    data['status'] = this.status;
    return data;
  }
}