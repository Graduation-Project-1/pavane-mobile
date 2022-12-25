class AllProductsModel {
  AllProductsModel({
      this.success, 
      this.status, 
      this.message, 
      this.data, 
      this.totalResult, 
      this.totalPages,});

  AllProductsModel.fromJson(dynamic json) {
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
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
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
  List<String>? categoryList;
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
    map['categoryList'] = categoryList;
    map['__v'] = v;
    map['cover'] = cover;
    return map;
  }

}