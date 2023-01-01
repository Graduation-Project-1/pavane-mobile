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
      this.role, 
      this.numberOfLikes, 
      this.numberOfReviews, 
      this.averageRate, 
      this.phone, 
      this.categoryList, 
      this.image, 
      this.coverImage,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    role = json['role'];
    numberOfLikes = json['numberOfLikes'];
    numberOfReviews = json['numberOfReviews'];
    averageRate = json['averageRate'];
    phone = json['phone'] != null ? json['phone'].cast<String>() : [];
    if (json['categoryList'] != null) {
      categoryList = [];
      json['categoryList'].forEach((v) {
        categoryList?.add(CategoryList.fromJson(v));
      });
    }
    image = json['image'];
    coverImage = json['coverImage'];
  }
  String? id;
  String? name;
  String? email;
  String? role;
  int? numberOfLikes;
  int? numberOfReviews;
  int? averageRate;
  List<String>? phone;
  List<CategoryList>? categoryList;
  String? image;
  String? coverImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['role'] = role;
    map['numberOfLikes'] = numberOfLikes;
    map['numberOfReviews'] = numberOfReviews;
    map['averageRate'] = averageRate;
    map['phone'] = phone;
    if (categoryList != null) {
      map['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    map['image'] = image;
    map['coverImage'] = coverImage;
    return map;
  }

}

class CategoryList {
  CategoryList({
      this.id, 
      this.name, 
      this.image,});

  CategoryList.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    image = json['image'];
  }
  String? id;
  String? name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }

}