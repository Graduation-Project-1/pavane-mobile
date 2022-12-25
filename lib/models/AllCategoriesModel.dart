class AllCategoriesModel {
  AllCategoriesModel({
      this.success, 
      this.status, 
      this.message, 
      this.data, 
      this.totalResult, 
      this.totalPages,});

  AllCategoriesModel.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    totalResult = json['totalResult'];
    totalPages = json['totalPages'];
  }
  bool? success;
  int? status;
  String? message;
  List<Data>? data;
  int? totalResult;
  int? totalPages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    map['totalResult'] = totalResult;
    map['totalPages'] = totalPages;
    return map;
  }

}

class Data {
  Data({
      this.id, 
      this.name, 
      this.image, 
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    image = json['image'];
    v = json['__v'];
  }
  String? id;
  String? name;
  String? image;
  int? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['__v'] = v;
    return map;
  }

}