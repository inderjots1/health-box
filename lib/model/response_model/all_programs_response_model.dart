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
  String program_image_path;
  String programArDescribe;
  String programEnDescribe;
  String programDuration;
  String programCost;
  String programDiscount;
  String programTypeEn;
  String programTypeAr;

  Programs(
      {this.programId,
        this.programTitleAr,
        this.programTitleEn,
        this.program_image_path,
        this.programArDescribe,
        this.programEnDescribe,
        this.programDuration,
        this.programCost,
        this.programDiscount,
        this.programTypeEn,
        this.programTypeAr});

  Programs.fromJson(Map<String, dynamic> json) {
    programId = json['program_id'];
    programTitleAr = json['program_title_ar'];
    program_image_path = json['program_image_path'];
    programTitleEn = json['program_title_en'];
    programArDescribe = json['program_ar_describe'];
    programEnDescribe = json['program_en_describe'];
    programDuration = json['program_duration'];
    programCost = json['program_cost'];
    programDiscount = json['program_discount'];
    programTypeEn = json['program_type_en'];
    programTypeAr = json['program_type_ar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['program_id'] = this.programId;
    data['program_title_ar'] = this.programTitleAr;
    data['program_image_path'] = this.program_image_path;
    data['program_title_en'] = this.programTitleEn;
    data['program_ar_describe'] = this.programArDescribe;
    data['program_en_describe'] = this.programEnDescribe;
    data['program_duration'] = this.programDuration;
    data['program_cost'] = this.programCost;
    data['program_discount'] = this.programDiscount;
    data['program_type_en'] = this.programTypeEn;
    data['program_type_ar'] = this.programTypeAr;
    return data;
  }
}

