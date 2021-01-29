class OrderHistoryResposneModel {
  List<Programs> programs;
  String status;
  String jwt;

  OrderHistoryResposneModel({this.programs, this.status, this.jwt});

  OrderHistoryResposneModel.fromJson(Map<String, dynamic> json) {
    if (json['programs'] != null) {
      programs = new List<Programs>();
      json['programs'].forEach((v) {
        programs.add(new Programs.fromJson(v));
      });
    }
    status = json['status'];
    jwt = json['jwt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.programs != null) {
      data['programs'] = this.programs.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    data['jwt'] = this.jwt;
    return data;
  }
}

class Programs {
  String participationId;
  String programStartDate;
  String programEndDate;

  Programs({this.participationId, this.programStartDate, this.programEndDate});

  Programs.fromJson(Map<String, dynamic> json) {
    participationId = json['participation_id'];
    programStartDate = json['program_start_date'];
    programEndDate = json['program_end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['participation_id'] = this.participationId;
    data['program_start_date'] = this.programStartDate;
    data['program_end_date'] = this.programEndDate;
    return data;
  }
}
