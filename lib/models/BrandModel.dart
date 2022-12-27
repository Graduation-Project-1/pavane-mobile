class BrandModel {
  BrandModel({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  BrandModel.fromJson(dynamic json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    data = json['Data'] != null ? Data.fromJson(json['Data']) : null;
  }
  bool? success;
  int? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
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
    if (json['categoryList'] != null) {
      categoryList = [];
      json['categoryList'].forEach((v) {
        categoryList?.add(CategoryList.fromJson(v));
      });
    }
    role = json['role'];
    v = json['__v'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? email;
  int? numberOfLikes;
  List<String>? phone;
  List<CategoryList>? categoryList;
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
    if (categoryList != null) {
      map['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    map['role'] = role;
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}

class CategoryList {
  CategoryList({
      this.id, 
      this.name, 
      this.v, 
      this.image,});

  CategoryList.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    v = json['__v'];
    image = json['image'];
  }
  String? id;
  String? name;
  int? v;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}