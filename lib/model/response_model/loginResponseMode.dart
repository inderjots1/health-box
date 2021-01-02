class LoginResponseModel {
  String status;
  String message;
  String jwt;
  User user;

  LoginResponseModel({this.status, this.message, this.jwt, this.user});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jwt = json['jwt'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
class User {
  String userId;
  String userName;
  String userEmail;
  String userPassword;
  String userTelep;
  String userAnotherTelep;
  String userGender;
  String userAge;
  String userTall;
  String userWeight;
  String userMotivation;
  String userGoalWeight;
  String userFirebase;
  String jwt;

  User(
      {this.userId,
        this.userName,
        this.userEmail,
        this.userPassword,
        this.userTelep,
        this.userAnotherTelep,
        this.userGender,
        this.userAge,
        this.userTall,
        this.userWeight,
        this.userMotivation,
        this.userGoalWeight,
        this.userFirebase,
        this.jwt});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPassword = json['user_password'];
    userTelep = json['user_telep'];
    userAnotherTelep = json['user_another_telep'];
    userGender = json['user_gender'];
    userAge = json['user_age'];
    userTall = json['user_tall'];
    userWeight = json['user_weight'];
    userMotivation = json['user_motivation'];
    userGoalWeight = json['user_goal_weight'];
    userFirebase = json['user_firebase'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_email'] = this.userEmail;
    data['user_password'] = this.userPassword;
    data['user_telep'] = this.userTelep;
    data['user_another_telep'] = this.userAnotherTelep;
    data['user_gender'] = this.userGender;
    data['user_age'] = this.userAge;
    data['user_tall'] = this.userTall;
    data['user_weight'] = this.userWeight;
    data['user_motivation'] = this.userMotivation;
    data['user_goal_weight'] = this.userGoalWeight;
    data['user_firebase'] = this.userFirebase;
    data['jwt'] = this.jwt;
    return data;
  }
}