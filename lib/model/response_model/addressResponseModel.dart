class AddressResponseModel {
  List<AreaItem> areaItem;

  AddressResponseModel({this.areaItem});

  AddressResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['area_item'] != null) {
      areaItem = new List<AreaItem>();
      json['area_item'].forEach((v) {
        areaItem.add(new AreaItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.areaItem != null) {
      data['area_item'] = this.areaItem.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AreaItem {
  String areaId;
  String areaNameAr;
  String areaNameEng;

  AreaItem({this.areaId, this.areaNameAr, this.areaNameEng});

  AreaItem.fromJson(Map<String, dynamic> json) {
    areaId = json['area_id'];
    areaNameAr = json['area_name_ar'];
    areaNameEng = json['area_name_eng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['area_id'] = this.areaId;
    data['area_name_ar'] = this.areaNameAr;
    data['area_name_eng'] = this.areaNameEng;
    return data;
  }
}