class AllBrandsModel {
  AllBrandsModel({
      this.success, 
      this.status, 
      this.message, 
      this.data, 
      this.totalResult, 
      this.totalPages,});

  AllBrandsModel.fromJson(dynamic json) {
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
      this.email, 
      this.numberOfLikes, 
      this.phone, 
      this.categoryList, 
      this.role, 
      this.v, 
      this.image,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    numberOfLikes = json['numberOfLikes'];
    phone = json['phone'] != null ? json['phone'].cast<String>() : [];
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    role = json['role'];
    v = json['__v'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? email;
  int? numberOfLikes;
  List<String>? phone;
  List<String>? categoryList;
  String? role;
  int? v;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['numberOfLikes'] = numberOfLikes;
    map['phone'] = phone;
    map['categoryList'] = categoryList;
    map['role'] = role;
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}