class RegisterModel {
  RegisterModel({
      this.success, 
      this.status, 
      this.message,});

  RegisterModel.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
  }
  bool? success;
  int? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    return map;
  }

}