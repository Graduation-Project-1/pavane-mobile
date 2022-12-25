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
      this.gender, 
      this.kids, 
      this.discountRate, 
      this.images, 
      this.availableSize, 
      this.availableColors, 
      this.vendorId, 
      this.categoryList, 
      this.v, 
      this.cover,});

  Data.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    numberOfReviews = json['numberOfReviews'];
    numberOfLikes = json['numberOfLikes'];
    gender = json['gender'];
    kids = json['kids'];
    discountRate = json['discountRate'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    availableSize = json['availableSize'] != null ? json['availableSize'].cast<String>() : [];
    availableColors = json['availableColors'] != null ? json['availableColors'].cast<String>() : [];
    vendorId = json['vendorId'];
    if (json['categoryList'] != null) {
      categoryList = [];
      json['categoryList'].forEach((v) {
        categoryList?.add(CategoryList.fromJson(v));
      });
    }
    v = json['__v'];
    cover = json['cover'];
  }
  String? id;
  String? name;
  int? price;
  String? description;
  int? numberOfReviews;
  int? numberOfLikes;
  String? gender;
  bool? kids;
  int? discountRate;
  List<String>? images;
  List<String>? availableSize;
  List<String>? availableColors;
  String? vendorId;
  List<CategoryList>? categoryList;
  int? v;
  String? cover;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['description'] = description;
    map['numberOfReviews'] = numberOfReviews;
    map['numberOfLikes'] = numberOfLikes;
    map['gender'] = gender;
    map['kids'] = kids;
    map['discountRate'] = discountRate;
    map['images'] = images;
    map['availableSize'] = availableSize;
    map['availableColors'] = availableColors;
    map['vendorId'] = vendorId;
    if (categoryList != null) {
      map['categoryList'] = categoryList?.map((v) => v.toJson()).toList();
    }
    map['__v'] = v;
    map['cover'] = cover;
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