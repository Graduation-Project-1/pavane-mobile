// ignore_for_file: prefer_typing_uninitialized_variables

class ProductModel {
  ProductModel({
      this.success, 
      this.status, 
      this.message, 
      this.data,});

  ProductModel.fromJson(dynamic json) {
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
      this.price, 
      this.description, 
      this.numberOfReviews, 
      this.numberOfLikes, 
      this.cover, 
      this.gender, 
      this.isAdult, 
      this.discountRate, 
      this.averageRate, 
      this.images, 
      this.sizes, 
      this.colors, 
      this.brandId, 
      this.categoryList,
      this.hasModel,
      this.isLiked,
      this.v,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    numberOfReviews = json['numberOfReviews'];
    numberOfLikes = json['numberOfLikes'];
    cover = json['cover'];
    gender = json['gender'];
    isAdult = json['isAdult'];
    discountRate = json['discountRate'];
    averageRate = json['averageRate'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    sizes = json['sizes'] != null ? json['sizes'].cast<String>() : [];
    colors = json['colors'] != null ? json['colors'].cast<String>() : [];
    brandId = json['brandId'] != null ? BrandId.fromJson(json['brandId']) : null;
    if (json['categoryList'] != null) {
      categoryList = [];
      json['categoryList'].forEach((v) {
        categoryList?.add(CategoryList.fromJson(v));
      });
    }
    v = json['__v'];
    isLiked = json['isLiked'];
    hasModel = json['hasModel'];
  }
  String? id;
  String? name;
  var price;
  String? description;
  var numberOfReviews;
  var numberOfLikes;
  String? cover;
  String? gender;
  bool? isAdult;
  var discountRate;
  var averageRate;
  List<String>? images;
  List<String>? sizes;
  List<String>? colors;
  BrandId? brandId;
  List<CategoryList>? categoryList;
  var v;
  var hasModel;
  var isLiked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    map['numberOfReviews'] = numberOfReviews;
    map['numberOfLikes'] = numberOfLikes;
    map['cover'] = cover;
    map['gender'] = gender;
    map['isAdult'] = isAdult;
    map['discountRate'] = discountRate;
    map['averageRate'] = averageRate;
    map['images'] = images;
    map['sizes'] = sizes;
    map['colors'] = colors;
    if (brandId != null) {
      map['brandId'] = brandId?.toJson();
    }
    if (categoryList != null) {
      map['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;
    map['isLiked'] = isLiked;
    map['hasModel'] = hasModel;
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
  var v;
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

class BrandId {
  BrandId({
      this.id, 
      this.name, 
      this.email, 
      this.password, 
      this.numberOfLikes, 
      this.phone, 
      this.categoryList, 
      this.role, 
      this.v, 
      this.image,});

  BrandId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
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
  String? password;
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
    map['password'] = password;
    map['numberOfLikes'] = numberOfLikes;
    map['phone'] = phone;
    map['categoryList'] = categoryList;
    map['role'] = role;
    map['__v'] = v;
    map['image'] = image;
    return map;
  }

}