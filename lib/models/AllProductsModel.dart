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
    categoryList = json['categoryList'] != null ? json['categoryList'].cast<String>() : [];
    v = json['__v'];
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
  List<String>? categoryList;
  var v;

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
    map['categoryList'] = categoryList;
    map['__v'] = v;
    return map;
  }

}

class BrandId {
  BrandId({
      this.id, 
      this.name,});

  BrandId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }

}