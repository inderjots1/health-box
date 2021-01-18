class ImageUploadResponseModel {
  String state;
  String imagePath;
  String message;

  ImageUploadResponseModel({this.state, this.imagePath, this.message});

  ImageUploadResponseModel.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    imagePath = json['image_path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['image_path'] = this.imagePath;
    data['message'] = this.message;
    return data;
  }
}