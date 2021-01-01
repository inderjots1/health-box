class GetAllProgramsResponseModel {
  List<Programs> programs;

  GetAllProgramsResponseModel({this.programs});

  GetAllProgramsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['programs'] != null) {
      programs = new List<Programs>();
      json['programs'].forEach((v) {
        programs.add(new Programs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.programs != null) {
      data['programs'] = this.programs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Programs {
  String programId;
  String programTitleAr;
  String programTitleEn;
  String programDuration;
  String programCost;
  String programDiscount;

  Programs(
      {this.programId,
        this.programTitleAr,
        this.programTitleEn,
        this.programDuration,
        this.programCost,
        this.programDiscount});

  Programs.fromJson(Map<String, dynamic> json) {
    programId = json['program_id'];
    programTitleAr = json['program_title_ar'];
    programTitleEn = json['program_title_en'];
    programDuration = json['program_duration'];
    programCost = json['program_cost'];
    programDiscount = json['program_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['program_id'] = this.programId;
    data['program_title_ar'] = this.programTitleAr;
    data['program_title_en'] = this.programTitleEn;
    data['program_duration'] = this.programDuration;
    data['program_cost'] = this.programCost;
    data['program_discount'] = this.programDiscount;
    return data;
  }
}